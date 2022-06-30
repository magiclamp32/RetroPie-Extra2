#!/bin/bash

# Menu GUI for bgm123 background music in RetroPie.

#autoconf
#fnocotua

function playPause() {
    if pgrep mpg123 >/dev/null; then
        bash "$md_inst/bgm_vol_fade.sh" &
    else
        sudo su "$user" -c "((vcgencmd force_audio hdmi 1) >/dev/null; sleep 1; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &"
    fi
}

function nextTrack() {
    pkill mpg123
    sudo su "$user" -c "((vcgencmd force_audio hdmi 1) >/dev/null; sleep 1; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &"
}

function showMenu() {
    local cmd=(dialog --backtitle "$__backtitle" --cancel-label "Back" --menu "Configuration menu for bgm123. Please choose an option." 22 86 16)
    while true; do
        local enabled=0
        grep '#bgm123' "$configdir/all/autostart.sh" >/dev/null && enabled=1
        local options=()
        if [[ "$enabled" -eq 1 ]]; then
            options+=(
                    E "Enable or disable background music (currently: Enabled)"
                )
            if pgrep emulationstatio >/dev/null; then
                options+=(
                    P "Play / pause"
                    N "Next track"
                )
            fi
        else
            options+=(
                E "Enable or disable background music (currently: Disabled)"
            )
        fi
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                E)
                    if [[ "$enabled" -eq 1 ]]; then
                        sudo su "$user" -c "sudo $scriptdir/retropie_packages.sh bgm123 disable"
                        dialog --backtitle "$__backtitle" --cr-wrap --no-collapse --msgbox "Background music disabled." 20 60 >/dev/tty
                    else
                        sudo su "$user" -c "sudo $scriptdir/retropie_packages.sh bgm123 enable"
                        dialog --backtitle "$__backtitle" --cr-wrap --no-collapse --msgbox "Background music enabled." 20 60 >/dev/tty
                    fi
                    ;;
                P)
                    playPause
                    ;;
                N)
                    nextTrack
                    ;;
            esac
        else
            break
        fi
    done
}

showMenu
