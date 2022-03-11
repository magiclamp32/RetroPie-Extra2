#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
#TODO get the expandions to work

rp_module_id="shadowwarrior"
rp_module_desc="Jfsw - Shadow warrior port"
rp_module_licence="GLP https://github.com/jonof/jfsw/blob/master/GPL.TXT"
rp_module_help="you need to put the game files in the shadowwarrior folder"
rp_module_repo="https://github.com/jonof/jfsw.git master"
rp_module_section="exp"
rp_module_flags=""

function depends_shadowwarrior() {
    getDepends cmake libgl1-mesa-dev libgtk2.0-dev libsdl1.2-dev libvorbis-dev timidity freepats
}

function sources_shadowwarrior() {
    gitPullOrClone "$md_build"
}

function build_shadowwarrior() {
    make DATADIR=/home/pi/RetroPie/roms/ports/shadowwarrior RELEASE=1 USE_POLYMOST=1 USE_OPENGL=USE_GLES2 WITHOUT_GTK=1 OPTOPT="-march=armv8-a+crc -mtune=cortex-a53"
    md_ret_require="$md_build/sw"
}

function install_shadowwarrior() {
    md_ret_files=(
    'sw'
    )
}
	
function configure_shadowwarrior() {
    mkRomDir "ports/shadowwarrior"
    addPort "$md_id" "sw" "Jfsw - Shadow Warrior source port" "XINIT: $md_inst/sw"
}
