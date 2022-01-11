#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="score"
rp_module_desc="score - Septerra Core: Legacy of the Creator port "
rp_module_licence="MIT https://github.com/M-HT/SR/blob/master/README.md"
rp_module_help="This port requires Septerra Core v1.04.\n\nInstall Septerra Core on your PC and copy the whole folder to /roms/ports/score."
rp_module_section="exp"
rp_module_flags="!mali"

function depends_score() {
    getDepends build-essential git scons automake gdc llvm libsdl2-dev libmpg123-dev libquicktime-dev libjudy-dev libsdl2-mixer-dev
}

function sources_score() {
   wget "$md_build" https://github.com/M-HT/SR/releases/download/septerra_v1.04.0.6/SepterraCore-Linux-armv7-gnueabihf-v1.04.0.6.tar.gz	
tar -xvf SepterraCore-Linux-armv7-gnueabihf-v1.04.0.6.tar.gz -C /home/pi/RetroPie-Setup/tmp/build/score

}


function install_score() {
     mkRomDir "ports/score"

	ln -s "/home/pi/RetroPie/roms/ports/score" "/home/pi/.config/" 
	 cd /home/pi/RetroPie-Setup/tmp/build/score
	cp -r SR-Septerra Septerra.cfg Septerra.sh readme-Linux.txt /home/pi/.config/score
	chown -R pi:pi "/home/pi/.config/score"
	chown -R pi:pi "/home/pi/RetroPie/roms/ports/score"

	md_ret_files=(
     )
}

function configure_score() {

	cat >"/home/pi/RetroPie/roms/ports/score/core.sh" << _EOF_
    
#!/bin/bash
cd "/home/pi/.config/score"
./SR-Septerra 
_EOF_

 chmod +x "/home/pi/RetroPie/roms/ports/score/core.sh"

	addPort "$md_id" "score" "SR-Septerra" "/home/pi/.config/score/core.sh"
	   
    }
