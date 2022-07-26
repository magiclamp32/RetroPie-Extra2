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

rp_module_id="pingus"
rp_module_desc="Pingus - Open source Lemmings clone"
rp_module_licence="GPL3 https://raw.githubusercontent.com/Pingus/pingus/master/COPYING"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function install_bin_pingus() {
    aptInstall pingus pingus-data xorg
}

function configure_pingus() {
    mkRomDir "ports"

    moveConfigDir "$home/.pingus" "$md_conf_root/$md_id"
    addPort "$md_id" "pingus" "Pingus" "XINIT: pingus"
}