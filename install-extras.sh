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
        echo -e "Error: RetroPie-Setup directory $RPS_HOME does not exist. Please input the location of RetroPie-Setup, ex:\n\n    ./$(basename "$0") /home/pi/RetroPie-Setup\n\nUse '-h' for help. Aborting."
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
Installation utility for RetroPie-Extra, a supplement to RetroPie

Usage:

    ./$(basename "$0") [-u|--update] [option] [rp_setup_directory]

Options:
    -a  --all       Add all RetroPie-Extra modules (may significantly impact
                    loading times of RetroPie-Setup and retropiemenu configuration
                    items, especially on slower hardware)
    -r  --remove    Remove all RetroPie-Extra modules (does not "uninstall" the modules
                    in RP-Setup)
    -h  --help      Display this help and exit
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
        echo -e "RetroPie-Extra directory $RP_EXTRA does not exist. Nothing to remove.\n\nAborting."
        exit
    fi

    echo -e "Removing directory $RP_EXTRA and all of its contents.\n"
    rm -rf "$RP_EXTRA" && echo "...done."
    exit
}

function runGui() {
    while true; do
        local cmd=(dialog --clear --backtitle "$BACKTITLE" --cancel-label "Exit" --menu "Choose an option" 22 86 16)
        local options=(
            1 "Choose which modules to install"
            2 "View or remove installed modules"
            3 "Update RetroPie-Extra"
            4 "Install all RetroPie-Extra modules"
            5 "Remove all RetroPie-Extra modules"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1) chooseModules ;;
                2) viewModules ;;
                3) updateExtras ;;
                4) guiAddAll ;;
                5) guiRemoveAll ;;
            esac
        else
            break
        fi
    done

    clear
}

function guiAddAll() {
    if dialog --clear --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "-- Install all\n\nThis may severely impact the loading time of RetroPie-Setup and retropiemenu configuration items, especially on slower hardware.\n\nDo you wish to continue?" 20 60 2>&1 >/dev/tty; then
        local errormsg="$(mkdir -p "$RP_EXTRA" 2>&1 && cp -rf "$SCRIPTDIR/scriptmodules" "$RP_EXTRA" 2>&1 && echo "All scriptmodules copied to $RP_EXTRA")"
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --programbox 20 60 2>&1 >/dev/tty < <(echo "$errormsg" | fold -w 56 -s)
    else
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "Operation canceled." 8 24 2>&1 >/dev/tty
    fi
}

function guiRemoveAll() {
    if [ ! -d "$RP_EXTRA" ]; then
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "-- Remove All\n\nRetroPie-Extra directory $RP_EXTRA does not exist. Nothing to remove.\n\nAborting." 20 60 2>&1 >/dev/tty
    elif dialog --clear --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "-- Remove All\n\nRemoving $RP_EXTRA and all of its contents. Do you wish to continue?" 20 60 2>&1 >/dev/tty; then
        local errormsg="$(rm -rf "$RP_EXTRA" 2>&1 && echo "...done.")"
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --programbox "Removing all RetroPie-Extra scriptmodules..." 20 60 2>&1 >/dev/tty < <(echo "$errormsg" | fold -w 56 -s)
    else
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "Operation canceled." 8 24 2>&1 >/dev/tty
    fi
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

    local choice
    local choices
    choices=($("${cmd[@]}" "${menu[@]}" 2>&1 >/dev/tty)) || return 1

    local errormsg="$(
        for choice in "${choices[@]}"; do
            if [[ "$choice" =~ $re ]]; then
                choice="${options[choice-1]}"
                copyModule "$choice"
            fi
        done
    )"

    local n="${#choices[@]}"
    if [[ -n "$errormsg" ]]; then
        errormsg="Error: $errormsg"
    elif [[ $n -eq 0 ]]; then
        errormsg="Error: no scriptmodules selected"
    else
        errormsg="$n selected scriptmodules have been copied to $RP_EXTRA"
    fi
    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --programbox 20 60 2>&1 >/dev/tty < <(echo "$errormsg" | fold -w 56 -s)
}

function copyModule() {
    local choice="$1"
    local section="$(dirname "$choice")"
    local script="scriptmodules/$choice"
    local target="$RP_EXTRA/scriptmodules/$section"
    local datadir="${script%.*}"

    mkdir -p "$target" 2>&1 \
      && cp -f "$script" "$target" 2>&1 \
      && [[ ! -d "$datadir" ]] || cp -rf "$datadir" "$target" 2>&1
}

function viewModules() {
    local menu=()
    local options=()
    local module
    local section
    local lastsection
    local re='^[0-9]+$'

    local i=1
    while read module; do
        module="${module/$RP_EXTRA\/scriptmodules\//}"
        section="$(dirname "$module")"
        if [[ "$section" != "$lastsection" ]]; then
            menu+=("---" "-----------[  $section  ]-----------" off)
        fi
        menu+=($i "$module" on)
        options+=("$module")
        ((i++))
        lastsection="$section"
    done < <(find "$RP_EXTRA/scriptmodules" -mindepth 2 -maxdepth 2 -type f | sort -u)

    if [[ -n "${options[@]}" ]]; then
        local cmd=(dialog --clear --backtitle "$BACKTITLE" --checklist "The following modules are installed:" 22 76 16)

        local choice
        local choices
        choices=($("${cmd[@]}" "${menu[@]}" 2>&1 >/dev/tty)) || return 1

        local keeps=()
        for choice in "${choices[@]}"; do
            if [[ "$choice" =~ $re ]]; then
                choice="${options[choice-1]}"
                keeps+=("$choice")
            fi
        done

        local removes=()
        for choice in "${options[@]}"; do
            [[ " ${keeps[*]} " =~ " $choice " ]] || removes+=("$choice")
        done

        [[ "${#removes[@]}" -eq 0 ]] && return

        if dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --defaultno --yesno "The following modules will be removed. Do you wish to continue?\n\n$(printf '    %s\n' "${removes[@]}")" 20 60 2>&1 >/dev/tty; then

            local errormsg="$(
                for choice in "${removes[@]}"; do
                    deleteModule "$choice"
                done
            )"

            if [[ -n "$errormsg" ]]; then
                errormsg="Error: $errormsg"
            else
                errormsg="${#removes[@]} selected scriptmodules removed."
            fi

            dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --programbox 20 60 2>&1 >/dev/tty < <(echo "$errormsg" | fold -w 56 -s)
        else
            dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "Operation canceled." 8 24 2>&1 >/dev/tty
        fi
    else
        dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --msgbox "Error: no scriptmodules installed" 20 60 2>&1 >/dev/tty
    fi
}

function deleteModule() {
    local choice="$1"
    local script="$RP_EXTRA/scriptmodules/$choice"
    local section="$(dirname "$script")"
    local datadir="${script%.*}"
    rm -f "$script" 2>&1 \
      && [[ ! -d "$datadir" ]] || rm -rf "$datadir" 2>&1 \
      && [[ ! -d "$section" ]] || [[ -n "$(ls -A "$section" 2>&1)" ]] || rmdir "$section" 2>&1 \
      && [[ ! -d "$RP_EXTRA/scriptmodules" ]] || [[ -n "$(ls -A "$RP_EXTRA/scriptmodules" 2>&1)" ]] || rmdir "$RP_EXTRA/scriptmodules" 2>&1 \
      && [[ ! -d "$RP_EXTRA" ]] || [[ -n "$(ls -A "$RP_EXTRA" 2>&1)" ]] || rmdir "$RP_EXTRA" 2>&1
}

function updateExtras () {
    local errormsg="$(git pull origin 2>&1)"
    dialog --backtitle "$BACKTITLE" --cr-wrap --no-collapse --programbox "Updating RetroPie-Extra" 20 60 2>&1 >/dev/tty < <(echo "$errormsg" | fold -w 56 -s)
}

# Run
startCmd
