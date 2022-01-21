#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="nxengine-evo"
rp_module_desc="Cave Story engine clone - NXEngine-Evo"
rp_module_help="NXEngine by Caitlin Shaw, refactoring by isage et al."
rp_module_licence="GPL3 http://nxengine.sourceforge.net/LICENSE"
rp_module_repo="git https://github.com/nxengine/nxengine-evo.git"
rp_module_section="exp"
rp_module_flags="!armv6 !mali"

function depends_nxengine-evo() {
    getDepends libpng-dev libjpeg-dev cmake libsdl2-dev libsdl2-gfx-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev 
}

function sources_nxengine-evo() {
    gitPullOrClone
}

function build_nxengine-evo() {
    mkdir build 
    cd build
    CFLAGS='-DDATADIR="\"/home/pi/RetroPie/roms/ports/cavestory/data/\""' CXXFLAGS='-DDATADIR="\"/home/pi/RetroPie/roms/ports/cavestory/data/\""' cmake -DCMAKE_BUILD_TYPE=Release -DPORTABLE=On ..
    make

    cd ..
    downloadAndExtract "https://www.cavestory.org/downloads/cavestoryen.zip" "cavestoryen"
    cp -r cavestoryen/caveStory/data .
    cp cavestoryen/caveStory/Doukutsu.exe .

    downloadAndExtract "https://github.com/nxengine/translations/releases/download/v1.14/all.zip" "translations"
    cp -r translations/data .

    build/nxextract
}

function install_nxengine-evo() {
   md_ret_files=(
        'build/nxengine-evo'
    )
   mkRomDir "ports/caveStory"
   cp -r data "$romdir/ports/caveStory"
}

function configure_nxengine-evo() {
    moveConfigDir "$home/.local/share/nxengine" "$md_conf_root/cavestory"
    addPort "$md_id" "cavestory" "Cave Story" "$md_inst/nxengine-evo"
    chown -R $user:$user "$romdir/ports/caveStory"
}
