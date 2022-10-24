#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="simutrans"
rp_module_desc="Simutrans - freeware and open-source transportation simulator"
rp_module_licence="GPL2 https://raw.githubusercontent.com/aburch/simutrans/master/LICENSE.txt"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_simutrans() {
    getDepends xorg timidity freepats
}

function install_bin_simutrans() {
    aptInstall simutrans
}

function configure_simutrans() {
    moveConfigDir "$home/.simutrans" "$md_conf_root/$md_id"
    addPort "$md_id" "simutrans" "Simutrans - transportation simulator" "XINIT: /usr/games/simutrans  -fullscreen -res 4"
}