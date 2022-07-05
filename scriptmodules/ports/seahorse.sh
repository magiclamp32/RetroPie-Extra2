#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="seahorse"
rp_module_desc="Seahorse Adventures: a side scrolling platform game with a bubble shooting seahorse (Bubble Bobble meets Blaster Master)"
rp_module_licence="GPL2 https://raw.githubusercontent.com/Nebuleon/barbie-seahorse-adventures/master/LICENSE.txt"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function install_bin_seahorse() {
    aptInstall seahorse-adventures
}

function configure_seahorse() {
    mkRomDir "ports"
    moveConfigDir "$home/.seahorse" "$md_conf_root/$md_id"

    addPort "$md_id" "seahorse" "Seahorse Adventures" "seahorse-adventures"
}
