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
rp_module_section="exp"
rp_module_flags="!mali"

function depends_dunelegacy() {

    getDepends autotools-dev libsdl2-mixer-dev libopusfile0 libsdl2-mixer-2.0-0 libsdl2-ttf-dev xorg matchbox-window-manager x11-xserver-utils  libfluidsynth-dev  libfluidsynth1 fluidsynth
}

function sources_dunelegacy() {
	gitPullOrClone "$md_build" git://dunelegacy.git.sourceforge.net/gitroot/dunelegacy/dunelegacy
}

function build_dunelegacy() {
	sed -i "/.*Mix_Init(MIX_INIT_FLUIDSYNTH | MIX_INIT_FLAC | MIX_INIT_MP3 | MIX_INIT_OGG);*/c\\Mix_Init(MIX_INIT_MID | MIX_INIT_FLAC | MIX_INIT_MP3 | MIX_INIT_OGG);." /home/pi/RetroPie-Setup/tmp/build/dunelegacy/src/FileClasses/music/DirectoryPlayer.cpp	
sed -i "/.*if((Mix_Init(MIX_INIT_FLUIDSYNTH) & MIX_INIT_FLUIDSYNTH) == 0) {.*/c\\if((Mix_Init(MIX_INIT_MID) & MIX_INIT_MID) == 0) {" /home/pi/RetroPie-Setup/tmp/build/dunelegacy/src/FileClasses/music/XMIPlayer.cpp	

	autoreconf --install
	./configure 
	make 
	
}

function install_dunelegacy() {
   	#mkdir -p /home/pi/.config/dunelegacy/data
	#ln -s "$romdir/ports/dunelegacy" "/home/pi/.config/dunelegacy/data/" 

	make install
}

function configure_dunelegacy() {
	mkdir -p /home/pi/RetroPie/roms/ports/dunelegacy/data
	mkdir -p /home/pi/.config/dunelegacy/
	addPort "$md_id" "dunelegacy" "Dune Legacy" "XINIT: /usr/local/bin/dunelegacy"     	
	ln -s "/home/pi/RetroPie/roms/ports/dunelegacy/data" "/home/pi/.config/dunelegacy/" 

	cp -r "$md_build/data" "$romdir/ports/$md_id"
	
	
	chown -R pi:pi  "/home/pi/.config/dunelegacy/"
	chown -R pi:pi  "/home/pi/RetroPie/roms/ports/dunelegacy"

}
