#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="freegish"
rp_module_desc="freegish - Open Source Gish clone"
rp_module_menus="4+"
rp_module_flags="!x86 !mali"

function depends_freegish() {
    getDepends libsdl1.2-dev git cmake libopenal-dev libvorbis-dev
}

function sources_freegish() {
    gitPullOrClone "$md_build" https://github.com/freegish/freegish.git
}

function build_freegish() {
    mkdir "$md_build/build"
    cd "$md_build/build"
    cmake -DCMAKE_INSTALL_PREFIX:PATH="$md_inst" ..
    make
}

function install_freegish() {
    cd "$md_build/build"
    make install
}

function configure_freegish() {
    mkRomDir "ports"
    #moveConfigDir "$home/.freegish" "$configdir/freegish"

    addPort "$md_id" "freegish" "freegish - Open Source Gish clone" "$md_inst/bin/freegish" 
}
