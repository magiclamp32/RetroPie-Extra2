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
    cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev -DCMAKE_INSTALL_PREFIX="$romdir/ports/CaveStory" ..
    make

    cd ..
    downloadAndExtract "https://www.cavestory.org/downloads/cavestoryen.zip"
    cp -r cavestoryen/CaveStory/data .
    cp cavestoryen/CaveStory/Doukutsu.exe .

    downloadAndExtract "https://github.com/nxengine/translations/releases/download/v1.14/all.zip" "translations"
    cp -r translations/data .

    build/nxextract
}

function install_nxengine-evo() {
    cd "$md_build/build"
    make install
}

function configure_nxengine-evo() {
    addPort "$md_id" "cavestory" "Cave Story" "$romdir/ports/CaveStory/bin/nxengine-evo"
    chown -R $user:$user "$romdir/ports/CaveStory"
}
