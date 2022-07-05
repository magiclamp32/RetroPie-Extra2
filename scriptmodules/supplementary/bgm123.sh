#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="bgm123"
rp_module_desc="Straightforward background music player using mpg123"
rp_module_help="Place your MP3 files in $datadir/bgm"
rp_module_section="exp"
rp_module_flags=""

function _get_vars_bgm123() {
    declare -A path=(
        [autostart]="$configdir/all/autostart.sh"
        [bashrc]="$home/.bashrc"
        [onstart]="$configdir/all/runcommand-onstart.sh"
        [onend]="$configdir/all/runcommand-onend.sh"
        [autoconf]="$configdir/all/$md_id.cfg"
        [menudir]="$datadir/retropiemenu"
        [init]="$md_inst/bgm_start.sh"
        [killscript]="$md_inst/bgm_stop.sh"
        [fadescript]="$md_inst/bgm_fade.sh"
    )

    local var
    for var in "$@"; do
        echo "local $var=${path[$var]}"
    done
}

function depends_bgm123() {
    getDepends mpg123
}

function install_bin_bgm123() {
    local vars=(
        'autoconf'
        'menudir'
    )
    $(_get_vars_bgm123 "${vars[@]}")

    local file
    local scripts=(
        'bgm_start.sh'
        'bgm_stop.sh'
        'bgm_fade.sh'
    )

    # copy scripts and include config
    for file in "${scripts[@]}"; do
        cp "$md_data/$file" "$md_inst"
        sed -i 's|.*#autoconf.*|source "'"$autoconf"'" #autoconf|' "$md_inst/$file"
    done

    # create rp menu items
    cp -f "$md_data/icon.png" "$menudir/icons/$md_id.png"
    touch "$menudir/$md_id.rp"
    chown -R $user:$user "$menudir"
}

function configure_bgm123() {
    local vars=(
        'autostart'
        'bashrc'
        'onstart'
        'onend'
        'autoconf'
        'menudir'
    )
    $(_get_vars_bgm123 "${vars[@]}")

    local share="$datadir/bgm"
    local file

    # find gamelist
    local gamelist="$menudir/gamelist.xml"
    [[ -f "$gamelist" ]] || gamelist="$configdir/all/emulationstation/gamelists/retropie/gamelist.xml"

    if [[ "$md_mode" == "remove" ]]; then
        # remove menu items and network share

        rm -f "$menudir/$md_id.rp" "$menudir/icons/$md_id.png"
        xmlstarlet ed -L -d "/gameList/game[contains(path,'$md_id.rp')]" "$gamelist"

        toggle_bgm123 "off"
        remove_share_samba "bgm"
        restart_samba

        return
    fi

    # preserve original file versions
    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        if [[ -f "$file" && ! -f "$file.old.$md_id" ]]; then
            cp -v "$file" "$file.old.$md_id"
            chown $user:$user "$file.old.$md_id"
        fi
    done

    # add gamelist entry
    if ! grep "<path>./$md_id.rp</path>" "$gamelist" >/dev/null; then
        xmlstarlet ed -L -s "/gameList" -t elem -n "gameTMP" \
          -s "//gameTMP" -t elem -n path -v "./$md_id.rp" \
          -s "//gameTMP" -t elem -n name -v "Background Music" \
          -s "//gameTMP" -t elem -n desc -v "Configure and control background music player. Enable or disable menu music while browsing and pause, resume, or skip current track." \
          -s "//gameTMP" -t elem -n image -v "./icons/$md_id.png" \
          -r "//gameTMP" -v "game" \
          "$gamelist"
    fi

    # create user config
    local tmp="$(mktemp)"
    iniConfig "=" '"' "$tmp"
    echo '# Configuration file for bgm123' > "$tmp"
    iniSet "status" "enabled"
    iniSet "sleep_timer" "10"
    iniSet "mixer_channel" "HDMI"
    iniSet "music_player" "mpg123"
    iniSet "music_dir" "$share"
    iniSet "mapped_volume" "enabled"
    copyDefaultConfig "$tmp" "$autoconf"
    rm -f "$tmp"

    # check for enable
    iniConfig "=" '"' "$autoconf"
    iniGet "status"
    [[ "$ini_value" == "enabled" ]] && toggle_bgm123 on

    # add music dir and network share
    mkUserDir "$share"
    add_share_samba "bgm" "$share"
    restart_samba
}

function toggle_bgm123() {
    local file
    local vars=(
        'autostart'
        'bashrc'
        'onstart'
        'onend'
        'autoconf'
        'init'
        'killscript'
        'fadescript'
    )
    $(_get_vars_bgm123 "${vars[@]}")

    # attempt to remove any existing bgm config
    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        [[ -f "$file" ]] && sed -i '/#bgm/d' "$file"
    done

    # enable with toggle "on" or "enable(d)"
    # disable with anything else
    if [[ "$1" == "on" || "$1" == "enable"?("d") ]]; then
        for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
            touch "$file"
            chown $user:$user "$file"
        done

        iniConfig "=" '"' "$autoconf"
        iniGet "sleep_timer"
        echo "$(echo '(sleep '"${ini_value:-10}"'; bash "'"$init"'") & #bgm123'; cat $autostart)" > "$autostart"
        echo '[[ "$(tty)" == "/dev/tty1" ]] && (bash "'"$killscript"'" &) #bgm123' >> "$bashrc"
        echo "$(echo 'bash "'"$fadescript"'" -STOP & #bgm123'; cat $onstart)" > "$onstart"
        echo '(sleep 1; bash "'"$fadescript"'" -CONT) & #bgm123' >> "$onend"

        printMsgs "console" "Background music enabled."
    else
        # kill player now since .bashrc won't do it later
        su "$user" -c "bash $killscript"

        for file in "$onstart" "$onend"; do
            # if file is now empty, remove it
            [[ -f "$file" && ! -s "$file" ]] && rm -f "$file"
        done

        printMsgs "console" "Background music disabled."
    fi
}

# dummy enable/disable functions for CLI
function disable_bgm123() {
    toggle_bgm123 off
}

function enable_bgm123() {
    toggle_bgm123 on
}

function gui_bgm123() {
    local vars=(
        'autostart'
        'autoconf'
        'init'
        'killscript'
        'fadescript'
    )
    $(_get_vars_bgm123 "${vars[@]}")

    iniConfig "=" '"' "$autoconf"
    local cmd=(dialog --backtitle "$__backtitle" --cancel-label "Back" --menu "Configuration for $md_id. Please choose an option." 22 86 16)
    while true; do
        # check if bgm code is actually enabled in autostart
        local status="disabled"
        grep '#bgm123' "$autostart" >/dev/null && status="enabled"

        local mapped
        iniGet "mapped_volume" && mapped="$ini_value"
        local sleep_timer
        iniGet "sleep_timer" && sleep_timer="$ini_value"

        local options=(
            1 "Enable or disable background music (currently: ${status^})"
            2 "Configure startup sleep timer (currently: ${sleep_timer:-(unset)} secs)"
            3 "Enable or disable mapped volume profile (currently: ${mapped^})"
        )
        if [[ "$status" == "enabled" ]] && pgrep emulationstatio >/dev/null; then
            options+=(
                P "Play / pause"
                N "Next track"
            )
        fi

        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    if [[ "$status" == "enabled" ]]; then
                        toggle_bgm123 off
                        iniSet "status" "disabled"
                        printMsgs "dialog" "Background music disabled."
                    else
                        toggle_bgm123 on
                        iniSet "status" "enabled"
                        printMsgs "dialog" "Background music enabled."
                    fi
                    ;;
                2)
                    sleep_timer=$(dialog --title "Sleep timer" --clear --rangebox "Choose how long to wait at startup before music starts" 0 60 0 90 ${sleep_timer:-10} 2>&1 >/dev/tty)
                    [[ -n "$sleep_timer" ]] && iniSet "sleep_timer" "${sleep_timer//[^[:digit:]]}"
                    ;;
                3)
                    if [[ "$mapped" == "enabled" ]]; then
                        iniSet "mapped_volume" "disabled"
                        printMsgs "dialog" "Mapped volume disabled."
                    else
                        iniSet "mapped_volume" "enabled"
                        printMsgs "dialog" "Mapped volume enabled."
                    fi
                    ;;
                P)
                    if pgrep mpg123 >/dev/null; then
                        su "$user" -c "bash $fadescript &"
                    else
                        su "$user" -c "bash $init &"
                    fi
                    ;;
                N)
                    su "$user" -c "(bash $killscript; sleep 1; bash $init) &"
                    ;;
            esac
        else
            break
        fi
    done
}
