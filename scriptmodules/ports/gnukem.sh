#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="gnukem"
rp_module_desc="Dave Gnukem - Duke Nukem 1 look-a-like"
rp_module_licence="MIT https://github.com/davidjoffe/dave_gnukem/blob/master/MIT-LICENSE.txt"
rp_module_section="exp"
rp_module_flags="noinstclean"


function depends_gnukem() {
   getDepends cmake libsdl1.2-dev libsdl-mixer1.2-dev xorg
}


function sources_gnukem() {

    gitPullOrClone "$md_build/" https://github.com/davidjoffe/dave_gnukem.git 
    gitPullOrClone "$md_build/data" https://github.com/davidjoffe/gnukem_data.git
	
}

function build_gnukem() {
   
    make

    md_ret_require="davegnukem"
      
}

function install_gnukem() {
    md_ret_files=( 
	'davegnukem'
	'data'
        
        )
}

function configure_gnukem() {
        addPort "$md_id" "gnukem" "Dave Gnukem - Duke Nukem 1 look-a-like" "XINIT:$md_inst/dave.sh"

cat >"$md_inst/dave.sh" << _EOF_

#!/bin/bash
cd "$md_inst"
./davegnukem -640 -f 

_EOF_

 chmod +x "$md_inst/dave.sh"

    mkRomDir "ports/dave"

   
  
}
