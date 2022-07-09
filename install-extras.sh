#!/bin/bash

MODE="gui"
if [[ "${1,,}" == "-a" || "${1,,}" == "--all" ]]; then
    MODE="auto"
    shift
fi
readonly MODE

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
    elif [[ "$MODE" == "auto" ]]; then
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
    while true; do
        local cmd=(dialog --clear --backtitle "$BACKTITLE" --cancel-label "Exit" --menu "Choose an option." 22 86 16)
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
                        errormsg="All scriptmodules copied to $RP_EXTRA"
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
    local options_b=()
    local module
    local section
    local lastsection
    local i=1

    while read module; do
        module="${module/scriptmodules\//}"
        section="$(dirname $module)"
        if [[ "$section" != "$lastsection" ]]; then
            options+=("---" "------[  $section  ]------" off)
        fi
        options+=($i "$module" off)
        options_b+=($i "$module" off)
        ((i++))
        lastsection="$section"
    done < <(find scriptmodules -mindepth 2 -maxdepth 2 -type f | sort -u)

    local cmd=(dialog --clear --backtitle "$BACKTITLE" --checklist "Choose which modules to install:" 22 60 16)

    local choices=($("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty))
    if [[ -n "$choices" ]]; then
        local choice
        local errormsg

        for choice in "${choices[@]}"; do
            choice="${options_b[choice*3-2]}"
            errormsg+=("$(copyModule $choice)") || break
        done
        if [[ -n "$errormsg" ]]; then
            errormsg="Error: $errormsg"
        else
            errormsg="The selected scriptmodules have been copied to $RP_EXTRA"
        fi
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
    fi
}

function copyModule() {
    local choice="$1"
    local section="$(dirname $choice)"
    local script="scriptmodules/$choice"
    local datadir="${script%.*}"
    local target="$RP_EXTRA/scriptmodules/$section"

    mkdir -p "$target" 2>&1 && \
    cp -f "$script" "$target" 2>&1 && \
    [[ ! -d "$datadir" ]] || cp -rf "$datadir" "$target" 2>&1
}

# Run
startCmd
