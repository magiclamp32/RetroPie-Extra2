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
    case "$1" in
        autostart) echo "$configdir/all/autostart.sh" ;;
        bashrc) echo "$home/.bashrc" ;;
        onstart) echo "$configdir/all/runcommand-onstart.sh" ;;
        onend) echo "$configdir/all/runcommand-onend.sh" ;;
        autoconf) echo "$configdir/all/$md_id.cfg" ;;
        menudir) echo "$datadir/retropiemenu" ;;
        init) echo "$md_inst/bgm_start.sh" ;;
        killscript) echo "$md_inst/bgm_stop.sh" ;;
        fadescript) echo "$md_inst/bgm_fade.sh" ;;
    esac
}

function depends_bgm123() {
    getDepends mpg123
}

function install_bin_bgm123() {
    local autoconf && autoconf="$(_get_vars_bgm123 autoconf)"
    local menudir && menudir="$(_get_vars_bgm123 menudir)"
    local file
    local scripts=(
        'bgm_start.sh'
        'bgm_stop.sh'
        'bgm_fade.sh'
    )

    for file in "${scripts[@]}"; do
        cp "$md_data/$file" "$md_inst"
        sed -i 's|.*#autoconf.*|source "'"$autoconf"'" #autoconf|' "$md_inst/$file"
    done

    cp -f "$md_data/icon.png" "$menudir/icons/$md_id.png"
    touch "$menudir/$md_id.rp"
    chown -R $user:$user "$menudir"
}

function configure_bgm123() {
    local autostart && autostart="$(_get_vars_bgm123 autostart)"
    local bashrc && bashrc="$(_get_vars_bgm123 bashrc)"
    local onstart && onstart="$(_get_vars_bgm123 onstart)"
    local onend && onend="$(_get_vars_bgm123 onend)"
    local autoconf && autoconf="$(_get_vars_bgm123 autoconf)"
    local menudir && menudir="$(_get_vars_bgm123 menudir)"
    local share="$datadir/bgm"
    local file

    local gamelist="$menudir/gamelist.xml"
    [[ -f "$gamelist" ]] || gamelist="$configdir/all/emulationstation/gamelists/retropie/gamelist.xml"

    if [[ "$md_mode" == "remove" ]]; then
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

    if ! grep "<path>./$md_id.rp</path>" "$gamelist" >/dev/null; then
        xmlstarlet ed -L -s "/gameList" -t elem -n "gameTMP" \
          -s "//gameTMP" -t elem -n path -v "./$md_id.rp" \
          -s "//gameTMP" -t elem -n name -v "Background Music" \
          -s "//gameTMP" -t elem -n desc -v "Configure and control background music player. Enable or disable menu music while browsing and pause, resume, or skip current track." \
          -s "//gameTMP" -t elem -n image -v "./icons/$md_id.png" \
          -r "//gameTMP" -v "game" \
          "$gamelist"
    fi

    [[ -f "$autoconf"  ]] || toggle_bgm123 on

    local tmp
    tmp="$(mktemp)"
    iniConfig "=" '"' "$tmp"
    echo '# Configuration file for bgm123' > "$tmp"
    iniSet "mixer_channel" "HDMI"
    iniSet "music_player" "mpg123"
    iniSet "music_dir" "$share"
    iniSet "mapped_volume" "enabled"
    copyDefaultConfig "$tmp" "$autoconf"
    rm -f "$tmp"

    mkUserDir "$share"
    add_share_samba "bgm" "$share"
    restart_samba
}

function toggle_bgm123() {
    local autostart && autostart="$(_get_vars_bgm123 autostart)"
    local bashrc && bashrc="$(_get_vars_bgm123 bashrc)"
    local onstart && onstart="$(_get_vars_bgm123 onstart)"
    local onend && onend="$(_get_vars_bgm123 onend)"
    local init && init="$(_get_vars_bgm123 init)"
    local killscript && killscript="$(_get_vars_bgm123 killscript)"
    local fadescript && fadescript="$(_get_vars_bgm123 fadescript)"
    local file

    # backup files and attempt to remove any existing bgm config
    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        if [[ -f "$file" ]]; then
            cp -f "$file" "$file.bak"
            chown $user:$user "$file.bak"
            sed -i '/#bgm/d' "$file"
        fi
    done

    if [[ "$1" == "on" || "$1" == "enable"?("d") ]]; then
        for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
            touch "$file"
            chown $user:$user "$file"
        done

        echo "$(echo -e 'while pgrep omxplayer >/dev/null; do sleep 1; done #bgm123\n(sleep 10; bash "'"$init"'") & #bgm123'; cat $autostart)" > "$autostart"
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

## because I still keep trying to use the old ones on command-line:
function disable_bgm123() {
    toggle_bgm123 off
}

function enable_bgm123() {
    toggle_bgm123 on
}

function gui_bgm123() {
    local autostart && autostart="$(_get_vars_bgm123 autostart)"
    local autoconf && autoconf="$(_get_vars_bgm123 autoconf)"
    local init && init="$(_get_vars_bgm123 init)"
    local killscript && killscript="$(_get_vars_bgm123 killscript)"
    local fadescript && fadescript="$(_get_vars_bgm123 fadescript)"

    local cmd=(dialog --backtitle "$__backtitle" --cancel-label "Back" --menu "Configuration for $md_id. Please choose an option." 22 86 16)
    iniConfig "=" '"' "$autoconf"
    while true; do
        local status="disabled"
        grep '#bgm123' "$autostart" >/dev/null && status="enabled"

        local mapped
        iniGet "mapped_volume" && mapped="$ini_value"

        local options=(
            1 "Enable or disable background music (currently: ${status^})"
            2 "Enable or disable mapped volume profile (currently: ${mapped^})"
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
                        printMsgs "dialog" "Background music disabled."
                    else
                        toggle_bgm123 on
                        printMsgs "dialog" "Background music enabled."
                    fi
                    ;;
                2)
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
