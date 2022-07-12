#!/bin/bash

SCRIPTDIR="$(dirname "$0")"
SCRIPTDIR="$(cd "$SCRIPTDIR" && pwd)"
readonly SCRIPTDIR

MODE="gui"
case "${1,,}" in
    -u|--update)
        shift
        git pull origin && "./$(basename "$0")" "$@"
        exit
        ;;
    -a|--all)
        MODE="auto"
        shift
        ;;
    -r|--remove)
        MODE="remove"
        shift
        ;;
    -*)
        MODE="help"
        shift
        ;;
esac
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
        echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./$(basename "$0") /home/pi/RetroPie-Setup\n\nUse '-h' for help. Aborting."
        exit
    fi

    case "$MODE" in
        help) runHelp ;;
        auto) runAuto ;;
        remove) removeAll ;;
        *) runGui ;;
    esac
}

function runHelp() {
    cat >/dev/tty << _BREAK_
Installation utility for RetroPie-Extra, a supplement to RetroPie.

Usage:

    ./$(basename "$0") [-u|--update] [option] [rp_setup_directory]

Options:
    -a  --all       Add all RetroPie-Extra modules (may significantly impact
                    loading times of RetroPie-Setup and retropiemenu configuration
                    items, especially on slower hardware.)
    -r  --remove    Remove all RetroPie-Extra modules (does not "uninstall" the modules
                    in RP-Setup.)
    -h  --help      Display this help and exit.
_BREAK_
exit
}

function runAuto() {
    echo -e "Placing scriptmodules in $RP_EXTRA\n"
    mkdir -p "$RP_EXTRA"
    cp -r "$SCRIPTDIR/scriptmodules/" "$RP_EXTRA" && echo "...done."
    exit
}

function removeAll() {
    if [ ! -d "$RP_EXTRA" ]; then
        echo -e "RetroPie-Extra directory $RP_EXTRA doesn't exist. Nothing to remove.\n\nAborting."
        exit
    fi

    echo -e "Removing directory $RP_EXTRA and all of its contents.\n"
    rm -rf "$RP_EXTRA" && echo "...done."
    exit
}

function runGui() {
    while true; do
        local cmd=(dialog --clear --backtitle "$BACKTITLE" --cancel-label "Exit" --menu "Choose an option." 22 86 16)
        local options=(
            1 "Choose which modules to install"
            2 "Update RetroPie-Extra"
            3 "Install all RetroPie-Extra modules"
            4 "Remove all RetroPie-Extra modules"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    chooseModules
                    ;;
                2)
                    updateExtras
                    ;;
                3)
                    if dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "-- Install all\n\nThis may severely impact the loading time of RetroPie-Setup and retropiemenu configuration items, especially on slower hardware.\n\nDo you wish to continue?" 20 60 2>&1 >/dev/tty; then
                        local errormsg=$(mkdir -p "$RP_EXTRA" 2>&1 && cp -r "$SCRIPTDIR/scriptmodules/" "$RP_EXTRA" 2>&1)
                        if [[ -n "$errormsg" ]]; then
                            errormsg="Error: $errormsg"
                        else
                            errormsg="All scriptmodules copied to $RP_EXTRA"
                        fi
                        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60 2>&1 >/dev/tty
                    fi
                    ;;
                4)
                    if [ ! -d "$RP_EXTRA" ]; then
                        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "-- Remove All\n\nRetroPie-Extra directory $RP_EXTRA doesn't exist. Nothing to remove.\n\nAborting." 20 60 2>&1 >/dev/tty
                    elif dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "-- Remove All\n\nRemoving $RP_EXTRA and all of its contents. Do you wish to continue?" 20 60 2>&1 >/dev/tty; then
                        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --prgbox "Removing all RetroPie-Extra scriptmodules..." "rm -rf \"$RP_EXTRA\" && echo \"...done.\"" 20 60 2>&1 >/dev/tty
                    fi
                    ;;
            esac
        else
            break
        fi
    done

    clear
}

function chooseModules() {
    local menu=()
    local options=()
    local module
    local section
    local lastsection
    local installed
    local re='^[0-9]+$'

    local i=1
    while read module; do
        module="${module/scriptmodules\//}"
        section="$(dirname "$module")"
        if [[ "$section" != "$lastsection" ]]; then
            menu+=("---" "-----------[  $section  ]-----------" off)
        fi
        installed="off"
        [[ -f "$RP_EXTRA/scriptmodules/$module" ]] && installed="on"
        menu+=($i "$module" "$installed")
        options+=("$module")
        ((i++))
        lastsection="$section"
    done < <(find scriptmodules -mindepth 2 -maxdepth 2 -type f | sort -u)

    local cmd=(dialog --clear --backtitle "$BACKTITLE" --checklist "Choose which modules to install:" 22 76 16)

    local choices=($("${cmd[@]}" "${menu[@]}" 2>&1 >/dev/tty))
    if [[ -n "$choices" ]]; then
        local choice
        local errormsg

        local n=0
        for choice in "${choices[@]}"; do
            if [[ "$choice" =~ $re ]]; then
                choice="${options[choice-1]}"
                errormsg+=("$(copyModule "$choice")") || break
                ((n++))
            fi
        done
        if [[ -n "$errormsg" ]]; then
            errormsg="Error: $errormsg"
        elif [[ $n -eq 0 ]]; then
            errormsg="Error: no scriptmodules selected"
        else
            errormsg="$n selected scriptmodules have been copied to $RP_EXTRA"
        fi
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
    fi
}

function copyModule() {
    local choice="$1"
    local section="$(dirname "$choice")"
    local script="scriptmodules/$choice"
    local datadir="${script%.*}"
    local target="$RP_EXTRA/scriptmodules/$section"

    mkdir -p "$target" 2>&1 \
      && cp -f "$script" "$target" 2>&1 \
      && [[ ! -d "$datadir" ]] || cp -rf "$datadir" "$target" 2>&1
}

function updateExtras () {
    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --prgbox "Updating RetroPie-Extra" "git pull origin" 22 76 2>&1 >/dev/tty
}

# Run
startCmd
