#!/bin/bash

SCRIPTDIR="$(dirname "$0")"
SCRIPTDIR="$(cd "$SCRIPTDIR" && pwd)"
readonly SCRIPTDIR

MODE="gui"
if [[ "${1,,}" == "-a" || "${1,,}" == "--all" ]]; then
    MODE="auto"
    shift
elif [[ "${1,,}" == "-r" || "${1,,}" == "--remove" ]]; then
    MODE="remove"
    shift
elif [[ "${1,,}" == "-h" || "${1,,}" == "--help" ]]; then
    MODE="help"
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
        echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./$(basename $0) /home/pi/RetroPie-Setup\n\nUse '-h' for help. Aborting."
        exit
    elif [[ "$MODE" == "auto" ]]; then
        runAuto
    elif [[ "$MODE" == "remove" ]]; then
        removeAll
    elif [[ "$MODE" == "help" ]]; then
        runHelp
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

function removeAll() {
    if [ ! -d "$RP_EXTRA" ]; then
        echo -e "RetroPie-Extra directory $RP_EXTRA doesn't exist. Nothing to remove.\n\nAborting."
        exit
    fi

    read -r -p "Removing directory $RP_EXTRA and all of its contents. Do you wish to continue? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            rm -rf "$RP_EXTRA" && echo -e "\n...done."
            ;;
        [yY]*)
            echo -e "\nError \"$response\": please enter \"y\" or \"yes\" to confirm.\n\nAborting."
            exit
            ;;
        *)
            echo -e "\nAborting."
            exit
            ;;
    esac

    exit
}

function runHelp() {
    cat >/dev/tty << _BREAK_
Installation utility for RetroPie-Extra, a supplement to RetroPie.

Usage: ./$(basename "$0") [option] [rp_setup_directory]

Options (choose one):
    -a  --all       Add all RetroPie-Extra modules (may significantly impact
                    loading times of RetroPie-Setup and retropiemenu configuration
                    items.)
    -r  --remove    Remove all RetroPie-Extra modules (does not "uninstall" the modules
                    in RP-Setup.)
    -h  --help      Display this help and exit.
_BREAK_
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
                    if dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "  -- Install all --\n\nThis may severely impact the loading time of RP Setup and RP Menu configuration items, especially on slower hardware.\n\nDo you wish to continue?" 20 60 2>&1 >/dev/tty; then
                        local errormsg=$(mkdir -p $RP_EXTRA 2>&1 && cp -r scriptmodules $RP_EXTRA 2>&1)
                        if [[ -n "$errormsg" ]]; then
                            errormsg="Error: $errormsg"
                        else
                            errormsg="All scriptmodules copied to $RP_EXTRA"
                        fi
                        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "$errormsg" 20 60
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
    local i=1
    local re='^[0-9]+$'
    local installed

    while read module; do
        module="${module/scriptmodules\//}"
        section="$(dirname $module)"
        if [[ "$section" != "$lastsection" ]]; then
            menu+=("---" "------[  $section  ]------" off)
        fi
        installed="off"
        [[ -f "$RP_EXTRA/scriptmodules/$module" ]] && installed="on"
        menu+=($i "$module" "$installed")
        options+=("$module")
        ((i++))
        lastsection="$section"
    done < <(find scriptmodules -mindepth 2 -maxdepth 2 -type f | sort -u)

    local cmd=(dialog --clear --backtitle "$BACKTITLE" --checklist "Choose which modules to install:" 22 60 16)

    local choices=($("${cmd[@]}" "${menu[@]}" 2>&1 >/dev/tty))
    if [[ -n "$choices" ]]; then
        local choice
        local errormsg

        local n=0
        for choice in "${choices[@]}"; do
            if [[ "$choice" =~ $re ]]; then
                choice="${options[choice-1]}"
                errormsg+=("$(copyModule $choice)") || break
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
    local section="$(dirname $choice)"
    local script="scriptmodules/$choice"
    local datadir="${script%.*}"
    local target="$RP_EXTRA/scriptmodules/$section"

    mkdir -p "$target" 2>&1 \
      && cp -f "$script" "$target" 2>&1 \
      && ([[ ! -d "$datadir" ]] || cp -rf "$datadir" "$target" 2>&1)
}

# Run
startCmd
