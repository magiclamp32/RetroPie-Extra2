#!/bin/bash

GUI=0
if [[ "${1,,}" == "-i" || "${1,,}" == "--interactive" ]]; then
    GUI=1
    shift
fi
readonly GUI

RPS_HOME="$HOME/RetroPie-Setup"
if [[ -n "$1" ]]; then
    RPS_HOME="$1"
fi
readonly RPS_HOME
readonly RP_EXTRA="$RPS_HOME/ext/RetroPie-Extra"
readonly BACKTITLE="Installation utility for RetroPie-Extra - Setup directory: $RPS_HOME"

if [[ ! -d "$RPS_HOME" ]]; then
    echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./$(basename $0) /home/pi/RetroPie-Setup\n\nAborting."
    exit
fi

function startCmd() {
    if [[ "$GUI" -eq 1 ]]; then
        runGUI
    else
        runAuto
    fi
}

function runAuto() {
    echo "Placing scriptmodules in $RP_EXTRA"
    mkdir -p "$RP_EXTRA"
    cp -R scriptmodules/ "$RP_EXTRA" && echo -e "\n...done."
    exit
}

function runGUI() {
    cmd=(dialog --clear --backtitle "$BACKTITLE" --menu "Choose an option." 22 86 16)
    while true; do
        local options=(
            1 "Install all RetroPie-Extra modules"
            2 "Choose which modules to install"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    local errormsg=$(mkdir -p "$RP_EXTRA" && cp -r scriptmodules "$RP_EXTRA")
                    if [[ -n "$errormsg" ]]; then
                        errormsg="Error: $errormsg"
                    else
                        errormsg="All scriptmodules copied to $RP_EXTRA."
                    fi
                    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
                    ;;
                2)
                    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "Coming soon..." 20 60
                    ;;
            esac
        else
            break
        fi
    done

    clear
}

startCmd
