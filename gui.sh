#!/bin/bash

GUI=0
if [[ "${1,,}" == "-i" ]]; then
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

if [[ ! -d "$RPS_HOME" ]]; then
    echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./install-extras.sh /home/pi/RetroPie-Setup\n\nAborting."
    exit
fi

if [[ "$GUI" -eq 0 ]]; then
    echo "Placing scriptmodules in $RP_EXTRA"
    mkdir -p "$RP_EXTRA"
    cp -R scriptmodules/ "$RP_EXTRA" && echo "...done."
    exit
fi

backtitle="Installation utility for RetroPie-Extra - Setup directory: $RPS_HOME"
cmd=(dialog --backtitle "$backtitle" --menu "Choose an option." 22 86 16)
while true; do
    local options=(
        1 "Install all RetroPie-Extra modules"
        2 "Choose which modules to install"
    )
    choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                errormsg=$(mkdir -p "$RP_EXTRA" && cp -r scriptmodules "$RP_EXTRA")
                if [[ -n "$err" ]]; then
                    errormsg="Error: $errormsg"
                else
                    errormsg="All scriptmodules copied to $RP_EXTRA."
                fi
                dialog --backtitle "$backtitle" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
                ;;
            2)
                dialog --backtitle "$backtitle" --cr-wrap --no-collapse --msgbox "Coming soon..." 20 60
                ;;
        esac
    else
        break
    fi
done

clear
