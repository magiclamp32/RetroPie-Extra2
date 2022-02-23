#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="opendune"
rp_module_desc="OpenDune - Dune 2 port using the OpenRA engine"
rp_module_help="Please put your data files in the roms/ports/opendune/data folder"
rp_module_licence="GNU https://github.com/OpenDUNE/OpenDUNE/blob/master/COPYING"
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_opendune() {
   getDepends libsdl2-image-dev libsdl2-dev  libsdl-image1.2-dev libsdl1.2-dev dos2unix zip timidity timidity-daemon xorg matchbox-window-manager x11-xserver-utils 
}


function sources_opendune() {
    gitPullOrClone "$md_build" https://github.com/OpenDUNE/OpenDUNE.git
}

function build_opendune() {
    ./configure --with-asound --without-oss --without-pulse --with-sdl2 --without-munt
    make

    md_ret_require=(
      )
}

function install_opendune() {
    md_ret_files=(bin/opendune
		bin/opendune.ini.sample
)
	
    cp $md_inst/opendune.ini.sample "/home/pi/.config/opendune/opendune.ini"
	
    sed -i "/.*;datadir=$usr$local$opendune.*/c\\datadir=/home/pi/RetroPie/roms/ports/opendune" /home/pi/.config/opendune/opendune.ini
    sed -i "/.*;fullscreen=1.*/c\\fullscreen=1" /home/pi/.config/opendune/opendune.ini
    sed -i "/.*;language=french.*/c\\language=english" /home/pi/.config/opendune/opendune.ini
}

function configure_opendune() {
    mkRomDir "ports/opendune"
    addPort "$md_id" "opendune" "OpenDune - Dune 2 port" "XINIT: $md_inst/opendune"

  	 #ln -sf "$romdir/ports/opendune" "$md_inst/opendune"
}
