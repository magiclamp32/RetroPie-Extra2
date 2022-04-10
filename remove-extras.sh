#!/bin/bash

RPS_HOME="$HOME/RetroPie-Setup"
if [ ! -z "$1" ]; then
    RPS_HOME="$1"
fi
RP_EXTRA="$RPS_HOME/ext/RetroPie-Extra"

if [ ! -d "$RPS_HOME" ]; then
    echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./remove-extras.sh /home/pi/RetroPie-Setup\n\nAborting."
    exit
elif [ ! -d "$RP_EXTRA" ]; then
    echo -e "RetroPie-Extra directory $RP_EXTRA doesn't exist. Nothing to remove.\nAborting."
    exit
fi

read -r -p "Removing directory $RP_EXTRA and all of its contents. Do you wish to continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        rm -rf "$RPS_HOME/ext/RetroPie-Extra" && echo -e "...done."
        ;;
    [yY]*)
        echo -e "Error \"$response\": please enter \"y\" or \"yes\" to confirm.\nAborting."
        exit
        ;;
    *)
        echo -e "Aborting."
        exit
        ;;
esac
