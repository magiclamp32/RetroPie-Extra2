#!/bin/bash

# Installation utility for RetroPie-Extra
#
# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

#!/bin/bash

RPS_HOME="$HOME/RetroPie-Setup"
if [ ! -z "$1" ]; then
    RPS_HOME="$1"
fi
RP_EXTRA="$RPS_HOME/ext/RetroPie-Extra"

if [ ! -d "$RPS_HOME" ]; then
    echo -e "Error: RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of RetroPie-Setup, ex:\n\n    ./install-extras.sh /home/pi/RetroPie-Setup\n\nAborting."
    exit
fi

echo -e "Placing scriptmodules in $RP_EXTRA"
mkdir -p "$RP_EXTRA"
cp -R scriptmodules "$RP_EXTRA" && echo -e "...done."