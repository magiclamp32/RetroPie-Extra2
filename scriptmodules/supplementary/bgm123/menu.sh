#!/bin/bash

# Menu GUI for bgm123 background music in RetroPie.

#menuconf
#autoconf

function disAble() {
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

function enAble() {
    local fadescript="$md_inst/bgm_vol_fade.sh"
    local file

    disAble

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        touch "$file"
        chown $user:$user "$file"
    done

    echo -e "$(echo -e 'while pgrep omxplayer >/dev/null; do sleep 1; done #bgm123\n((vcgencmd force_audio hdmi 1) >/dev/null; sleep 6; (pgrep emulationstatio >/dev/null && mpg123 -Z "'$datadir'/bgm/"*.[mM][pP]3 >/dev/null 2>&1)) & #bgm123'; cat $autostart)" > "$autostart"
    echo '[[ "$(tty)" == "/dev/tty1" ]] && ((vcgencmd force_audio hdmi 0) >/dev/null; sleep 0.5; pkill mpg123) #bgm123' >> "$bashrc"
    echo 'bash "'"$fadescript"'" -STOP & #bgm123' >> "$onstart"
    echo '(sleep 1; "bash '"$fadescript"'" -CONT) & #bgm123' >> "$onend"
}

function playPause() {
    if pgrep mpg123 >/dev/null; then
        bash "$md_inst/bgm_vol_fade.sh" &
    else
        ((vcgencmd force_audio hdmi 1) >/dev/null; sleep 0.5; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &
    fi
}

function nextTrack() {
    pkill mpg123
    ((vcgencmd force_audio hdmi 1) >/dev/null; sleep 0.5; mpg123 -Z $datadir/bgm/*.[mM][pP]3 >/dev/null 2>&1) &
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
                        disAble
                        dialog --backtitle "$__backtitle" --cr-wrap --no-collapse --msgbox "Background music disabled." 20 60 >/dev/tty
                    else
                        enAble
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
