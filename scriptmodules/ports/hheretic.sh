#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="hheretic"
rp_module_desc="heretic port"
rp_module_help="Please put your heretic.wad in the roms/ports/heretic folder" 
rp_module_licence="GNU https://sourceforge.net/p/hhexen/hhexen/ci/master/tree/LICENSE.md"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_hheretic() {
    apt-get update --allow-releaseinfo-change 

	getDepends libsndifsdl2-dev libsdl-mixer1.2-dev libgl1 libsdl-image1.2-dev xorg matchbox-window-manager x11-xserver-utils
}

function sources_hheretic() {

	wget https://sourceforge.net/projects/hhexen/files/hheretic/0.2.3/hheretic-0.2.3-src.tgz 
	 tar -xzvf hheretic-0.2.3-src.tgz 
}

function build_hheretic() {
   	cd hheretic-0.2.3-src
	 ./configure --enable-fullscreen --with-audio=sdlmixer --with-datapath=/home/pi/RetroPie/roms/ports/heretic

	make 
	
    md_ret_require=hheretic-gl
}

function install_hheretic() {
    md_ret_files=(hheretic-0.2.3-src/hheretic-gl
	
 )
}

function configure_hheretic() {

	mkRomDir "ports/heretic"
	 addPort "$md_id" "hheretic" "Heretic port" "XINIT: $md_inst/hheretic-gl -width 1920 -height 1080"

}
