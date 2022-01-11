#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="openrct"
rp_module_desc="openrct - RollerCoaster Tycoon 2 port"
rp_module_licence="GNU https://github.com/OpenRCT2/OpenRCT2/blob/develop/licence.txt"
rp_module_help="Copy g1.dat, The 772 default RCT2 objects. /n/nEasy to identify by sorting on date, /n/nsince all 772 have a similar timestamp (usually from 2002 or 2003/n/n Required: If you use the OpenRCT2 title sequence, no scenarios are needed./n/n Six Flags Magic Mountain.SC6/n/n is needed for the RCT2 title sequence."
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_openrct() {
   getDepends xorg matchbox-window-manager x11-xserver-utils libsdl2-dev libicu-dev gcc pkg-config libjansson-dev libspeex-dev libspeexdsp-dev libcurl4-openssl-dev libcrypto++-dev libfontconfig1-dev libfreetype6-dev libpng-dev libssl-dev libzip-dev build-essential make libbenchmark-dev libbenchmark1 libbenchmark-ocaml-dev duktape-dev libduktape203

	echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' | sudo tee -a /etc/apt/sources.list
	
	 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
	
	 apt update
	
	 apt install -t buster-backports nlohmann-json3-dev
}


function sources_openrct() {

    git clone -b master --depth 1 --recursive https://github.com/OpenRCT2/OpenRCT2.git 
	git clone https://github.com/Exarkuniv/RCTconfig.git 
}

function build_openrct() {
	mkdir "/home/pi/.config/OpenRCT2"
	chown -R pi:pi "/home/pi/.config/OpenRCT2"

	cp "$md_build/RCTconfig/config.ini" "/home/pi/.config/OpenRCT2"

    mkdir $md_build/OpenRCT2/build
    cd $md_build/OpenRCT2/build
    cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-Ofast -DNDEBUG -mcpu=cortex-a72"
	
    make -j4

	 make install

    md_ret_require=( 
	'openrct2'
      )
}

function install_openrct() {
    md_ret_files=(
	'OpenRCT2/build'
	'OpenRCT2/data'
	'OpenRCT2/resources'
        )
}

function configure_openrct() {
chmod +x "/home/pi/.config/OpenRCT2/config.ini"

	cat >"$md_inst/rct.sh" << _EOF_

    
#!/bin/bash
cd "/opt/retropie/ports/openrct/build"
./openrct2 
_EOF_

 chmod +x "$md_inst/rct.sh"

        addPort "$md_id" "openrct2" "Rollercoaster tycoon 2" "XINIT:$md_inst/rct.sh"

    mkRomDir "ports/openrct2"
	mkRomDir "ports/openrct1"
   
}
