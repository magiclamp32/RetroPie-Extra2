#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="easyrpg"
rp_module_desc="EasyRPG - An Open Source RPG Maker 2000/2003 Interpreter"
rp_module_menus="4+"
rp_module_flags="!x86 !mali"

function depends_easyrpg() {
    getDepends libsdl2-dev libsdl2-mixer-dev libpng12-dev libfreetype6-dev libboost-dev libpixman-1-dev zlib1g-dev autoconf automake
}

function sources_easyrpg() {
    gitPullOrClone "$md_build/liblcf" https://github.com/EasyRPG/liblcf.git 
    gitPullOrClone "$md_build/player" https://github.com/EasyRPG/Player.git
}

function build_easyrpg() {
    cd liblcf
    autoreconf -i
    ./configure --prefix "$md_inst"
    make

    cd ../player
    autoreconf -i
    LD_FLAGS="-L "$md_build/liblcf/" ./configure --prefix "$md_inst"
    make
    cd ..
    
    md_ret_require="$md_build/player/easyrpg-player"
}

function install_easyrpg() {
    cd liblcf/
    make install

    cd ../player
    make install
}

function configure_easyrpg() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkUserDir "$configdir/$md_id"

    moveConfigFile "config.xml" "$configdir/$md_id/config.xml"
    moveConfigFile "hiscores.xml" "$configdir/$md_id/hiscores.xml"

    if [[ ! -f "$configdir/$md_id/config.xml" ]]; then
        cp -v "$md_inst/config.xml.def" "$configdir/$md_id/config.xml"
    fi

    cp -v roms.txt "$romdir/ports/$md_id/"

    chown -R $user:$user "$romdir/ports/$md_id" "$configdir/$md_id"

    ln -snf "$romdir/ports/$md_id" "$md_inst/roms"

    addPort "$md_id" "cannonball" "Cannonball - OutRun Engine" "pushd $md_inst; $md_inst/cannonball; popd"

    __INFMSGS+=("You need to unzip your OutRun set B from latest MAME (outrun.zip) to $romdir/ports/$md_id. They should match the file names listed in the roms.txt file found in the roms folder. You will also need to rename the epr-10381a.132 file to epr-10381b.132 before it will work.")
}
