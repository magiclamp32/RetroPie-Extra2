#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://github.com/Exarkuniv/RetroPie-Extra/blob/master/LICENSE
#

rp_module_id="quakespasm"
rp_module_desc="Quakespasm - Another enhanced engine for quake"
rp_module_licence="GNU https://sourceforge.net/p/quakespasm/quakespasm/ci/master/tree/LICENSE.txt"
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_quakespasm() {
   getDepends libmad0-dev libmpg123-0 libogg0 libvorbis-dev gambas3-gb-opengl-glsl glslang-dev libsdl2-dev
}


function sources_quakespasm() {

    gitPullOrClone "$md_build" git://git.code.sf.net/p/quakespasm/quakespasm.git
}

function build_quakespasm() {
  	cd Quake
	  make USE_SDL2=1 DO_USERDIRS=1
	
    md_ret_require=(
      )
}

function install_quakespasm() {
    md_ret_files=(Quake/quakespasm
	Quake/quakespasm.pak        
        )
}

function configure_quakespasm() {
        addPort "$md_id" "quakespasm" "Quakespasm - Quake engine" "$md_inst/quakespasm -basedir /home/pi/RetroPie/roms/ports/quake"

    mkRomDir "ports/quake"
   

   
}
