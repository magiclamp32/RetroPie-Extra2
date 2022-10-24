#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="samtfe"
rp_module_desc="SamTFE - Serious Sam Classic The First Encounter"
rp_module_licence="GPL2 https://raw.githubusercontent.com/tx00100xt/SeriousSamClassic/main/LICENSE"
rp_module_help="Copy all *.gro files and Help folder from the game directory to SamTSE directory. At the current time the files are:
\nHelp (folder)\nLevels (folder)\n1_00_ExtraTools.gro\n1_00_music.gro\n1_00c_Logo.gro\n1_00c.gro\n1_00c_scripts.gro\n1_04_patch.gro"
rp_module_repo="git https://github.com/tx00100xt/SeriousSamClassic.git main"
rp_module_section="exp"
rp_module_flags=""

function depends_samtfe() {
    getDepends libogg-dev libvorbis-dev xorg
}

function sources_samtfe() {
    gitPullOrClone 
}

function build_samtfe() {
    cd "$md_build/SamTFE/Sources"
    ./build-linux64.sh -DTFE=TRUE -DRPI4=TRUE
}

function install_samtfe() {
   md_ret_files=(  
    'SamTFE/Bin'
    'SamTFE/SE1_10b.gro'

)
}

function configure_samtfe() {
    mkdir -p "$md_inst/tfe"
    sudo mv -v "/opt/retropie/ports/samtfe/Bin" "/opt/retropie/ports/samtfe/tfe"
    sudo mv -v "/opt/retropie/ports/samtfe/SE1_10b.gro" "/opt/retropie/ports/samtfe/tfe"

   mkRomDir "ports/$md_id"
   ln -sf "/opt/retropie/ports/$md_id/tfe" "$romdir/ports/$md_id/"
    local script="$md_inst/$md_id.sh"
      cat > "$script" << _EOF_

#!/bin/bash

"$md_inst/tfe/Bin/SeriousSam"

_EOF_
    chmod +x "$md_inst/$md_id.sh"
    chown -R $user:$user "/opt/retropie/ports/samtfe/tfe"
    addPort "$md_id" "samtfe" "Serious Sam Classic The First Encounter" "XINIT: $script %ROM%"
}
