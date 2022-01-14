#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="nxengine"
rp_module_desc="Cave Story engine clone - NXEngine-Evo"
rp_module_licence="GPL3 http://nxengine.sourceforge.net/LICENSE"
rp_module_help=""
rp_module_section="opt"
rp_module_flags="!armv6 !mali"

function depends_nxengine() {
   sudo apt install build-essential libpng-dev libjpeg-dev make cmake cmake-data git libsdl2-dev libsdl2-doc libsdl2-gfx-dev libsdl2-gfx-doc libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev libsdl2-ttf-dev 
}

function sources_nxengine() {
   git clone https://github.com/nxengine/nxengine-evo.git
}

function build_nxengine() {
     cd nxengine-evo
     mkdir build 
     cd build
     cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/pi/RetroPie/roms/ports/CaveStory ..
     make

     cd ..
     wget "https://www.cavestory.org/downloads/cavestoryen.zip"
     unzip cavestoryen.zip
     cp -r CaveStory/data/ ./
	cp -r CaveStory/Doukutsu.exe ./

    wget "https://github.com/nxengine/translations/releases/download/v1.14/all.zip"
    mkdir translations && unzip all.zip -d translations
    cp -r translations/data ./

	build/nxextract
}

function install_nxengine() {
     cd nxengine-evo/build
	sudo make install
}

function configure_nxengine() {
    addPort "$md_id" "cavestory" "Cave Story" "/home/pi/RetroPie/roms/ports/CaveStory/bin/nxengine-evo"
       chown -R $user:$user "/home/pi/RetroPie/roms/ports/CaveStory"
}
