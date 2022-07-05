#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://github.com/Exarkuniv/RetroPie-Extra/blob/master/LICENSE
#

rp_module_id="supertuxkart"
rp_module_desc="SuperTuxKart - a free kart-racing game featuring the Linux mascot Tux the Penguin, inspired by the popular Mario Kart series of racers."
rp_module_licence="GPL3 https://sourceforge.net/p/supertuxkart/code/HEAD/tree/main/trunk/COPYING?format=raw"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_supertuxkart() {
    getDepends xorg
}

function install_bin_supertuxkart() {
    aptInstall supertuxkart
}

function remove_supertuxkart() {
    aptRemove supertuxkart supertuxkart-data
}

function configure_supertuxkart() {
    addPort "$md_id" "supertuxkart" "SuperTuxKart" "XINIT:$md_inst/supertuxkart.sh"
    [[ "$md_mode" == "remove" ]] && return

    # create script for launch
    # is this needed?
    cat >"$md_inst/supertuxkart.sh" << _EOF_
#!/bin/bash
/usr/games/supertuxkart
_EOF_
    chmod +x "$md_inst/supertuxkart.sh"
}
