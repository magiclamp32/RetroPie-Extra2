#!/bin/bash

AUTO=0
if [[ "${1,,}" == "-a" || "${1,,}" == "--all" ]]; then
    AUTO=1
    shift
fi
readonly AUTO

RPS_HOME="$HOME/RetroPie-Setup"
if [[ -n "$1" ]]; then
    RPS_HOME="$1"
fi
readonly RPS_HOME

readonly RP_EXTRA="$RPS_HOME/ext/RetroPie-Extra"
readonly BACKTITLE="Installation utility for RetroPie-Extra - Setup directory: $RPS_HOME"

function startCmd() {
    if [[ ! -d "$RPS_HOME" ]]; then
        echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./$(basename $0) /home/pi/RetroPie-Setup\n\nAborting."
        exit
    elif [[ "$AUTO" -eq 1 ]]; then
        runAuto
    else
        runGUI
    fi
}

function runAuto() {
    echo -e "Placing scriptmodules in $RP_EXTRA\n"
    mkdir -p "$RP_EXTRA"
    cp -R scriptmodules/ "$RP_EXTRA" && echo "...done."
    exit
}

function runGUI() {
    cmd=(dialog --clear --backtitle "$BACKTITLE" --menu "Choose an option." 22 86 16)
    while true; do
        local options=(
            1 "Choose which modules to install"
            2 "Install all RetroPie-Extra modules"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    chooseModules
                    ;;
                2)
                    local errormsg=$(mkdir -p $RP_EXTRA 2>&1 && cp -r scriptmodules $RP_EXTRA 2>&1)
                    if [[ -n "$errormsg" ]]; then
                        errormsg="Error: $errormsg"
                    else
                        errormsg="All scriptmodules copied to $RP_EXTRA."
                    fi
                    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
                    ;;
            esac
        else
            break
        fi
    done

    clear
}

function chooseModules() {
    local options=()
    local module
    local i=1

    local cmd=(dialog --backtitle "$BACKTITLE" --checklist "Choose which modules to install:" 22 60 16)

    while read module; do
        module="${module/scriptmodules\//}"
        options+=($i "$module" off)
        ((i++))
    done < <(find scriptmodules -mindepth 2 -maxdepth 2 -type f | sort -u)

    local choices=($("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty))
    local choice
    local script
    local datadir
    local section
    local target

    for choice in "${choices[@]}"; do
        script="scriptmodules/${options[choice*3-2]}"
        section="$(basename $(dirname $script))"
        datadir="${script%.*}"
        target="$RP_EXTRA/scriptmodules/$section"

        [[ ! -d "$target" ]] && mkdir -p "$target"
        cp -f "$script" "$target"
        [[ -d "$datadir" ]] && cp -r "$datadir" "$target"
    done

    clear
    exit
}

# Run
startCmd
