#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="samtse"
rp_module_desc="SamTSE - Serious Sam Classic The Second Encounter"
rp_module_licence="GPL2 https://raw.githubusercontent.com/tx00100xt/SeriousSamClassic/main/LICENSE"
rp_module_help="Copy all *.gro files and Help folder from the game directory to SamTSE directory. At the current time the files are:
\nHelp (folder)\nSE1_00.gro\nSE1_00_Extra.gro\nSE1_00_ExtraTools.gro\nSE1_00_Levels.gro\nSE1_00_Logo.gro\nSE1_00_Music.gro\n1_04_patch.gro\n1_07_tools.gro"
rp_module_repo="git https://github.com/tx00100xt/SeriousSamClassic.git main"
rp_module_section="exp"
rp_module_flags=""

function depends_samtse() {
    getDepends libogg-dev libvorbis-dev xorg
}

function sources_samtse() {
    gitPullOrClone 
}

function build_samtse() {
    cd "$md_build/SamTSE/Sources"
    ./build-linux64.sh -DRPI4=TRUE
}

function install_samtse() {
   md_ret_files=(
       'SamTSE/Bin'
       'SamTSE/SE1_10b.gro'
       'SamTSE/ModEXT.txt'
    )
}

function configure_samtse() {
    mkdir -p "$md_inst/tse"
    sudo mv -v "/opt/retropie/ports/samtse/Bin" "/opt/retropie/ports/samtse/tse"
    sudo mv -v "/opt/retropie/ports/samtse/SE1_10b.gro" "/opt/retropie/ports/samtse/tse"
    sudo mv -v "/opt/retropie/ports/samtse/ModEXT.txt" "/opt/retropie/ports/samtse/tse"

    mkRomDir "ports/$md_id"
       ln -sf "/opt/retropie/ports/$md_id/tse" "$romdir/ports/$md_id/"
    local script="$md_inst/$md_id.sh"
      cat > "$script" << _EOF_

#!/bin/bash
"$md_inst/tse/Bin/SeriousSam"
_EOF_
    chmod +x "$md_inst/$md_id.sh"
    chown -R pi:pi "/opt/retropie/ports/$md_id/tse"
    addPort "$md_id" "samtse" "Serious Sam Classic The Second Encounter" "XINIT: $script %ROM%"
}
