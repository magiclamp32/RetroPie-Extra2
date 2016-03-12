#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="easyrpg-lib"
rp_module_desc="EasyRPG-lib - Required library for RPG Maker 2000/2003 Interpreter"
rp_module_menus="4+"
rp_module_flags="!x86 !mali"

function depends_easyrpg-lib() {
    getDepends libsdl2-dev libsdl2-mixer-dev libpng12-dev libfreetype6-dev libboost-dev libpixman-1-dev zlib1g-dev autoconf automake
}

function sources_easyrpg-lib() {
    gitPullOrClone "$md_build" https://github.com/EasyRPG/liblcf.git
}

function build_easyrpg-lib() {
    autoreconf -i
    ./configure --prefix "$md_inst"
    make
}

function install_easyrpg-lib() {
    make install
}

function configure_easyrpg-lib() {
    __INFMSGS+=("You can now go ahead with the installation of EasyRPG.")
}
