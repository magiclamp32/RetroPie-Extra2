#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openmw"
rp_module_desc="openmw - Morrowind source port"
rp_module_licence="GPL3 https://github.com/OpenMW/osg/blob/3.4/LICENSE.txt"
rp_module_help=" Copy Morrowind.esm to the data folder/n/ If the install fails you need to install the openmwdriver first"
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_openmw() {

   getDepends cmake build-essential libopenal-dev libopenscenegraph-3.4-dev libsdl2-dev libqt4-dev libboost-filesystem-dev libboost-thread-dev libboost-program-options-dev libboost-system-dev libboost-iostreams-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libswresample-dev libbullet-dev libmygui-dev libunshield-dev libqt4-opengl-dev libtinyxml-dev xorg 
   
}

function _arch_openmw() {
    # exact parsing from Makefile
    echo "$(uname -m | sed -e 's/i.86/x86/' | sed -e 's/^arm.*/arm/')"
}


function sources_openmw() {
    local revision=openmw-0.46.0

    gitPullOrClone "$md_build" https://gitlab.com/OpenMW/openmw.git "" "$revision"
}

function build_openmw() {
    mkdir $md_build/build
    cd $md_build/build
    cmake ..

    make clean
    make

    md_ret_require=(
        "$md_build/build/bsatool"
        "$md_build/build/esmtool"
        "$md_build/build/gamecontrollerdb.txt"
        "$md_build/build/niftest"
        "$md_build/build/openmw"
        "$md_build/build/openmw-cs"
        "$md_build/build/openmw-cs.cfg"
        "$md_build/build/openmw-essimporter"
        "$md_build/build/openmw-iniimporter"
        "$md_build/build/openmw-launcher"
        "$md_build/build/openmw-wizard"
        "$md_build/build/openmw.cfg"
        "$md_build/build/settings-default.cfg"
        )
}

function install_openmw() {
    md_ret_files=(
        "build/bsatool"
        "build/esmtool"
        "build/gamecontrollerdb.txt"
        "build/niftest"
        "build/openmw"
        "build/openmw-cs"
        "build/openmw-cs.cfg"
        "build/openmw-essimporter"
        "build/openmw-iniimporter"
        "build/openmw-launcher"
        "build/openmw-wizard"
        "build/openmw.cfg"
        "build/resources"
        "build/settings-default.cfg"
        )
}

function configure_openmw() {
    local launcher=("$md_inst/openmw-launcher")

    addPort "$md_id" "morrowind" "The Elder Scrolls III - Morrowind" "XINIT: OPENMW_DECOMPRESS_TEXTURES=1 ${launcher[*]}"

    mkRomDir "ports/morrowind"
    moveConfigDir "$md_inst/data" "$romdir/ports/morrowind"
}
