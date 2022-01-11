#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="vanillacc"
rp_module_desc="Vanilla-Command and Conquer"
rp_module_licence="GNU https://github.com/TheAssemblyArmada/Vanilla-Conquer/blob/vanilla/License.txt"
rp_module_section="exp"
rp_module_help="you will need to vist my github.com/Exarkuniv/Vanilla-Conquer=RPI for more info"
rp_module_flags="noinstclean"


function depends_vanillacc() {
   getDepends cmake g++ cmake libsdl2-dev libopenal-dev
}


function sources_vanillacc() {

    wget https://github.com/TheAssemblyArmada/Vanilla-Conquer/archive/refs/tags/latest.tar.gz
	tar xvf latest.tar.gz
}

function build_vanillacc() {

	cd Vanilla-Conquer-latest
    mkdir build
    cd build
    CXXFLAGS=-fpermissive cmake .. 
	
    make -j4 
	cd ..

    md_ret_require=(
	'/home/pi/RetroPie-Setup/tmp/build/vanillacc/Vanilla-Conquer-latest/build/vanillara'
	'/home/pi/RetroPie-Setup/tmp/build/vanillacc/Vanilla-Conquer-latest/build/vanillatd'
		
	)
}

function install_vanillacc() {
    md_ret_files=(
	'Vanilla-Conquer-latest/build/vanillara'
		'Vanilla-Conquer-latest/build/vanillatd'
         )

	
  		 mkRomDir "ports/red alert"
		 mkRomDir "ports/tiberian dawn"
        ln -sf "$romdir/ports/red alert" "/opt/retropie/ports/vanillacc/" 
	ln -sf  "$romdir/ports/tiberian dawn" "/opt/retropie/ports/vanillacc/"

	

}

function configure_vanillacc() {
	mv "/opt/retropie/ports/vanillacc/vanillara" "$md_inst/red alert"
	mv "/opt/retropie/ports/vanillacc/vanillatd" "$md_inst/tiberian dawn"        

	addPort "$md_id" "vanillatd" "Vanilla-Command and Conquer" "'$md_inst/tiberian dawn/vanillatd'"
		
	addPort "$md_id" "red alert" "Vanilla-Red Alert" "'$md_inst/red alert/vanillara'"
		  
	
}
