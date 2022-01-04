#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="dunedynasty"
rp_module_desc="Dune Dynasty - Dune 2 Building of a Dynasty port"
rp_module_help="Please put your data files in the roms/ports/dunedynasty/data folder"
rp_module_licence="GNU 2.0 https://sourceforge.net/p/dunedynasty/dunedynasty/ci/master/tree/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_dunedynasty() {
    getDepends fluidsynth liballegro5.2 vlc-plugin-fluidsynth libfluidsynth1 madplay liballegro-acodec5-dev timidity liballegro-audio5-dev liballegro-image5-dev
}

function sources_dunedynasty() {

	wget https://sourceforge.net/projects/dunedynasty/files/dunedynasty-1.5/dunedynasty-1.5.7.tar.gz
	tar -xvf dunedynasty-1.5.7.tar.gz -C /home/pi/RetroPie-Setup/tmp/build/dunedynasty

}

function build_dunedynasty() {
	sed -i "/.*set(DUNE_DATA_DIR ".")*/c\\set(DUNE_DATA_DIR "/home/pi/RetroPie/roms/ports/dunedynasty/")" /home/pi/RetroPie-Setup/tmp/build/dunedynasty/dunedynasty-1.5.7/CMakeLists.txt
	cd dunedynasty-1.5.7
	mkdir build
	cd build
	cmake ..
	make 
    
	
    md_ret_require=
}

function install_dunedynasty() {
    md_ret_files=(
	"dunedynasty-1.5.7/build/dist/dunedynasty"
 )
}

function configure_dunedynasty() {
    cp "$md_build/dunedynasty-1.5.7/dist/dunedynasty.cfg-sample" "/home/pi/.config/dunedynasty/dunedynasty.cfg"
	sed -i "/.*window_mode=windowed*/c\\window_mode=fullscreen" /home/pi/.config/dunedynasty/dunedynasty.cfg
	sed -i "/.*screen_width=640*/c\\screen_width=1920" /home/pi/.config/dunedynasty/dunedynasty.cfg
	sed -i "/.*screen_height=480*/c\\screen_height=1080" /home/pi/.config/dunedynasty/dunedynasty.cfg
	sed -i "/.*menubar_scale=1.00*/c\\menubar_scale=10.00" /home/pi/.config/dunedynasty/dunedynasty.cfg
	sed -i "/.*sidebar_scale=1.00*/c\\sidebar_scale=10.00" /home/pi/.config/dunedynasty/dunedynasty.cfg
	sed -i "/.*viewport_scale=2.00*/c\\viewport_scale=10.00" /home/pi/.config/dunedynasty/dunedynasty.cfg
		
addPort "$md_id" "dunedynasty" "dune dynasty - Dune 2 port" "XINIT: $md_inst/dunedynasty"

    mkRomDir "ports/dunedynasty"
	mkRomDir "ports/dunedynasty/data"

		chown -R pi:pi  "/home/pi/.config/dunedynasty/"

}
