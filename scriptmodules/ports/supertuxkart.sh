#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="supertuxkart"
rp_module_desc="SuperTuxKart"
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


    cat >"$md_inst/supertuxkart.sh" << _EOF_
#!/bin/bash
/usr/games/supertuxkart
_EOF_
    chmod +x "$md_inst/supertuxkart.sh"
}
