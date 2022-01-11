#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="wizznic"
rp_module_desc="Awesome Puzzle Game"
rp_module_licence="http://wizznic.org/"
rp_module_section="exp"
rp_module_flags="!mali !x86"


function install_bin_wizznic() {
    aptInstall wizznic
}

function configure_wizznic() {
    mkRomDir "ports"
    touch "$md_inst/settings.ini"
    moveConfigFile "$md_inst/settings.ini" "$md_conf_root/$md_id/settings.ini"
    chown -R $user:$user "$md_conf_root/$md_id"
    addPort "$md_id" "wizznic" "Wizznic - Puzznic clone" "pushd $md_inst; $md_inst/wizznic -sw; popd"
}
