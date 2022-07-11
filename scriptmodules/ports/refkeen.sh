#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="refkeen"
rp_module_desc="Reflection Keen port for Keen Dreams, The Catacomb Adventure Series and Wolf3d"
rp_module_licence="GNU https://github.com/NY00123/refkeen/blob/master/LICENSES/gpl-2.0.txt"
rp_module_help="Copy your game files to the correct folders and use the ingame menu to navigate to the game to launch"
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_refkeen() {
   getDepends libspeexdsp1 libsdl2-2.0-0 libspeexdsp-dev

}
function sources_refkeen() {

    gitPullOrClone "$md_build" https://github.com/NY00123/refkeen.git
}

function build_refkeen() {
    mkdir $md_build/build
    cd $md_build/build
    cmake ..

    make

    md_ret_require=(
      )
}

function install_refkeen() {
    md_ret_files=(build/reflection-catacomb
	build/reflection-kdreams
	build/reflection-wolf3d

        )
}

function configure_refkeen() {
        addPort "$md_id" "refkeen" "Reflection Keen" "$md_inst/reflection-kdreams"
	addPort "$md_id" "recatacomb" "Reflection Catacomb 3-D" "$md_inst/reflection-catacomb"
	addPort "$md_id" "rewolf" "Reflection Wolfenstein 3D" "$md_inst/reflection-wolf3d"

	    mkRomDir "ports/keen"
	mkRomDir "ports/catacomb"
	mkRomDir "ports/wolf3d"
}
