#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="dunelegacy"
rp_module_desc="Dune Legacy - Dune 2 Building of a Dynasty port"
rp_module_help="Please put your data files in the roms/ports/dunelegacy/data folder"
rp_module_licence="GNU 2.0 https://sourceforge.net/p/dunedynasty/dunedynasty/ci/master/tree/COPYING"
rp_module_repo="git git://dunelegacy.git.sourceforge.net/gitroot/dunelegacy/dunelegacy"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_dunelegacy() {
    getDepends autotools-dev libsdl2-mixer-dev libopusfile0 libsdl2-mixer-2.0-0 libsdl2-ttf-dev xorg matchbox-window-manager x11-xserver-utils  libfluidsynth-dev  libfluidsynth1 fluidsynth
}

function sources_dunelegacy() {
    gitPullOrClone 
}

function build_dunelegacy() {
    params=(--prefix="$md_inst")
        sed -i "/*Mix_Init(MIX_INIT_FLUIDSYNTH | MIX_INIT_FLAC | MIX_INIT_MP3 | MIX_INIT_OGG)/c\\Mix_Init(MIX_INIT_MID | MIX_INIT_FLAC | MIX_INIT_MP3 | MIX_INIT_OGG)" $md_build/src/FileClasses/music/DirectoryPlayer.cpp	
sed -i "/if((Mix_Init(MIX_INIT_FLUIDSYNTH) & MIX_INIT_FLUIDSYNTH) == 0) {/c\\if((Mix_Init(MIX_INIT_MID) & MIX_INIT_MID) == 0) {" $md_build/src/FileClasses/music/XMIPlayer.cpp	

    autoreconf --install
    ./configure "${params[@]}"
    make 
	md_ret_require="$md_build/src/dunelegacy"
}

function install_dunelegacy() {
    make install
}

function game_data_dunelegacy() {
    if [[ ! -f "$romdir/ports/dune2/data/DUNE2.EXE" ]]; then
        downloadAndExtract "https://github.com/Exarkuniv/game-data/raw/main/dune-II.zip" "$romdir/ports/dune2"
    mv "$romdir/ports/dune2/dune-ii-the-building-of-a-dynasty/"* "$romdir/ports/dune2/data"
    rmdir "$romdir/ports/dune2/dune-ii-the-building-of-a-dynasty/"
    chown -R $user:$user "$romdir/ports/dune2"
    fi
}

function configure_dunelegacy() {
    mkRomDir "ports/dune2/data"
    moveConfigDir "$home/.config/dunelegacy" "$md_conf_root/dunelegacy"
    addPort "$md_id" "dunelegacy" "Dune Legacy" "XINIT: $md_inst/bin/dunelegacy"     	
    ln -s "/home/pi/RetroPie/roms/ports/dune2/data" "$home/.config/dunelegacy" 

    #cp -r "$md_build/data" "$romdir/ports/$md_id"=
    #chown -R pi:pi  "/home/pi/.config/dunelegacy/"
    #chown -R pi:pi  "/home/pi/RetroPie/roms/ports/dunelegacy"

    [[ "$md_mode" == "install" ]] && game_data_dunelegacy
}