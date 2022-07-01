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
rp_module_flags="!all rpi"

function _autostart_bgm123() {
    echo "$configdir/all/autostart.sh"
}

function _bashrc_bgm123() {
    echo "$home/.bashrc"
}

function _onstart_bgm123() {
    echo "$configdir/all/runcommand-onstart.sh"
}

function _onend_bgm123() {
    echo "$configdir/all/runcommand-onend.sh"
}

function _autoconf_bgm123() {
    echo "$configdir/all/$md_id.cfg"
}

function _gamelist_bgm123() {
    local xmlfile="$datadir/retropiemenu/gamelist.xml"
    [[ -f "$xmlfile" ]] || xmlfile="$configdir/all/emulationstation/gamelists/retropie/gamelist.xml"
    echo "$xmlfile"
}

function depends_bgm123() {
    getDepends mpg123
}

function install_bin_bgm123() {
    local scriptname="bgm_vol_fade.sh"

    cp "$md_data/$scriptname" "$md_inst"
    cp -f "$md_data/icon.png" "$datadir/retropiemenu/icons/$md_id.png"
    touch "$datadir/retropiemenu/$md_id.rp"
    chown -R $user:$user "$datadir/retropiemenu"
}

function configure_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"
    local autoconf
    autoconf="$(_autoconf_bgm123)"
    local gamelist
    gamelist="$(_gamelist_bgm123)"

    local share="$datadir/bgm"
    local file

    [[ "$md_mode" == "remove" ]] && return

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        # preserve original file versions
        if [[ -f "$file" && ! -f "$file.old.$md_id" ]]; then
            cp -v "$file" "$file.old.$md_id"
            chown $user:$user "$file.old.$md_id"
        fi
    done

    local tmp
    tmp="$(mktemp)"
    iniConfig "=" '"' "$tmp"
    echo -e '# Configuration file for bgm123\n' >> "$tmp"
    iniSet "installed" "0"
    iniSet "mapped_volume" "1"
    iniSet "music_player" "mpg123"
    copyDefaultConfig "$tmp" "$autoconf"
    rm -f "$tmp"

    sed -i 's|.*#autoconf.*|source "'"$autoconf"'" #autoconf|' "$md_inst/$scriptname"

    if ! grep "<path>./$md_id.rp</path>" "$gamelist" >/dev/null; then
        xmlstarlet ed -L -s "/gameList" -t elem -n "gameTMP" \
          -s "//gameTMP" -t elem -n path -v "./$md_id.rp" \
          -s "//gameTMP" -t elem -n name -v "Background Music" \
          -s "//gameTMP" -t elem -n desc -v "Configure and control background music player. Enable or disable menu music while browsing and pause, resume, or skip current track." \
          -s "//gameTMP" -t elem -n image -v "./icons/$md_id.png" \
          -r "//gameTMP" -v "game" \
          "$gamelist"
    fi

    mkUserDir "$share"
    add_share_samba "bgm" "$share"
    restart_samba

    iniConfig "=" '"' "$autoconf"
    iniGet "installed"
    [[ "$ini_value" -eq 0 ]] && enable_bgm123
    iniSet "installed" "1"
}

function enable_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"

    local fadescript="$md_inst/bgm_vol_fade.sh"
    local file

    disable_bgm123

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        touch "$file"
        chown $user:$user "$file"
    done

    echo -e "$(echo -e 'while pgrep omxplayer >/dev/null; do sleep 1; done #bgm123\n((vcgencmd force_audio hdmi 1) >/dev/null; sleep 8; (pgrep emulationstatio >/dev/null && mpg123 -Z "'$datadir'/bgm/"*.[mM][pP]3 >/dev/null 2>&1)) & #bgm123'; cat $autostart)" > "$autostart"
    echo '[[ "$(tty)" == "/dev/tty1" ]] && ((vcgencmd force_audio hdmi 0) >/dev/null; sleep 0.5; pkill mpg123) #bgm123' >> "$bashrc"
    echo 'bash "'"$fadescript"'" -STOP & #bgm123' >> "$onstart"
    echo '(sleep 1; "bash '"$fadescript"'" -CONT) & #bgm123' >> "$onend"
}

function disable_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"
    local file

    # kill player now since .bashrc won't do it later
    (vcgencmd force_audio hdmi 0) >/dev/null
    sleep 0.5
    pkill mpg123

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        if [[ -f "$file" ]]; then
            # backup file and attempt to remove any existing bgm config
            cp -f "$file" "$file.bak"
            chown $user:$user "$file.bak"
            sed -i '/#bgm/d' "$file"

            # if file is now empty, remove it
            [[ ! -s "$file" ]] && rm -f "$file"
        fi
    done
}

function remove_bgm123() {
    local gamelist
    gamelist="$(_gamelist_bgm123)"

    rm -f "$datadir/retropiemenu/$md_id.rp" "$datadir/retropiemenu/icons/$md_id.png"
    xmlstarlet ed -L -d "/gameList/game[contains(path,'$md_id.rp')]" "$gamelist"

    disable_bgm123
    remove_share_samba "bgm"
    restart_samba
}

function gui_bgm123() {
    local autoconf
    autoconf="$(_autoconf_bgm123)"

    local cmd=(dialog --backtitle "$__backtitle" --cancel-label "Back" --menu "Configuration for $md_id. Please choose an option." 22 86 16)
    while true; do
        local status="disabled"
        grep '#bgm123' "$configdir/all/autostart.sh" >/dev/null && status="enabled"

        local mapped="disabled"
        iniConfig "=" '"' "$autoconf"
        iniGet "mapped_volume"
        [[ "$ini_value" -eq 1 ]] && mapped="enabled"

        local options=(
            1 "Enable or disable background music (currently: ${status^})"
            2 "Enable or disable mapped volume profile (currently: ${mapped^})"
        )

        if [[ "${status,,}" == "enabled" ]] && pgrep emulationstatio >/dev/null; then
            options+=(
                P "Play / pause"
                N "Next track"
            )
        fi

        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    if [[ "${status,,}" == "enabled" ]]; then
                        disable_bgm123
                        printMsgs "dialog" "Background music disabled."
                    else
                        enable_bgm123
                        printMsgs "dialog" "Background music enabled."
                    fi
                    ;;
                2)
                    if [[ "${mapped,,}" == "enabled" ]]; then
                        iniSet "mapped_volume" "0"
                        printMsgs "dialog" "Mapped volume disabled."
                    else
                        iniSet "mapped_volume" "1"
                        printMsgs "dialog" "Mapped volume enabled."
                    fi
                    ;;
                P)
                    if pgrep mpg123 >/dev/null; then
                        su "$user" -c "bash $md_inst/bgm_vol_fade.sh &"
                    else
                        su "$user" -c "((vcgencmd force_audio hdmi 1) >/dev/null; sleep 0.5; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &"
                    fi
                    ;;
                N)
                    pkill mpg123
                    su "$user" -c "((vcgencmd force_audio hdmi 1) >/dev/null; sleep 0.5; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &"
                    ;;
            esac
        else
            break
        fi
    done
}
