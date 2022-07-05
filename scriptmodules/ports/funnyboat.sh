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

rp_module_id="funnyboat"
rp_module_desc="Funny Boat. A side scrolling boat shooter with waves."
rp_module_licence="GPL2 https://sourceforge.net/p/funnyboat/code/HEAD/tree/trunk/LICENSE-CODE.txt?format=raw"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function install_bin_funnyboat() {
    aptInstall funnyboat
}

function configure_funnyboat() {
    mkRomDir "ports"
    moveConfigDir "$home/.funnyboat" "$md_conf_root/$md_id"

    addPort "$md_id" "funnyboat" "Funny Boat" "funnyboat"
}
