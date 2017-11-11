#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="sorr"
rp_module_desc="Streets of Rage Remake"
rp_module_help="Please copy your SorR.dat file along with the mod and palettes folders into $md_inst."
rp_module_section="exp"
rp_module_flags="!x86 !x11 !mali"

function depends_sorr() {
    getDepends libsdl-mixer1.2
}

function sources_sorr() {
    gitPullOrClone "$md_build" https://github.com/zerojay/bennugd.git
}

function install_sorr() {
    md_ret_files=(
    'bgdi-330'
    )
}

function configure_sorr() {
    mkRomDir "ports"
    chmod 755 "$md_inst/bgdi-330"
    moveConfigFile "$md_inst/savegame" "$md_conf_root/$md_id/"
    addPort "$md_id" "sorr" "Streets of Rage Remake" "pushd $md_inst; ./bgdi-330 ./SorR.dat; popd"
}
