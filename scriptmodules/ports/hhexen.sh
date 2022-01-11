#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="hhexen"
rp_module_desc="Hexen port"
rp_module_help="Please put your heretic.wad in the roms/ports/hexen folder" 
rp_module_licence="GNU https://sourceforge.net/p/hhexen/hhexen/ci/master/tree/LICENSE.md"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_hhexen() {
    apt-get update --allow-releaseinfo-change 

	getDepends libsndifsdl2-dev libsdl-mixer1.2-dev libgl1 libsdl-image1.2-dev xorg matchbox-window-manager x11-xserver-utils
}

function sources_hhexen() {

	wget https://sourceforge.net/projects/hhexen/files/hhexen/1.6.3/hhexen-1.6.3-src.tgz 
	 tar -xzvf hhexen-1.6.3-src.tgz
}

function build_hhexen() {
   	cd hhexen-1.6.3-src
	 ./configure --enable-fullscreen --with-audio=sdlmixer --with-datapath=/home/pi/RetroPie/roms/ports/hexen

	make 
	
    md_ret_require=hhexen-gl
}

function install_hhexen() {
    md_ret_files=(hhexen-1.6.3-src/hhexen-gl
	
 )
}

function configure_hhexen() {

	mkRomDir "ports/hexen"
	 addPort "$md_id" "hhexen" "Hexen port" "XINIT: $md_inst/hhexen-gl -width 1920 -height 1080"
	 addPort "$md_id" "hhexen-dd" "Hexen -Deathkings of the Dark Citadel Port" "XINIT: $md_inst/hhexen-gl -file hexdd.wad -width 1920 -height 1080"
}
