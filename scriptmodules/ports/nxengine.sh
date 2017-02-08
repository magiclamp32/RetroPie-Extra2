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
rp_module_desc="Cave Story engine clone - NXEngine"
rp_module_help="Copy the original Cave Story game files to $romdir/ports/CaveStory so you have $romdir/ports/CaveStory/Doukutsu.exe and $romdir/ports/CaveStory/data present."
rp_module_section="opt"
rp_module_flags="!armv6 !mali"

function depends_nxengine() {
    getDepends libsdl1.2-dev libsdl-ttf2.0-dev
}

function sources_nxengine() {
    wget -O- -q http://nxengine.sourceforge.net/dl/nx-src-1006.tar.bz2 | tar -xvj --strip-components=1
}

function build_nxengine() {
    make clean
    make
}

function install_nxengine() {
    md_ret_files=('tilekey.dat'
                  'sprites.sif'
                  'smalfont.bmp'
                  'nx'
                  'font.ttf'
                  'debug.txt'
    )
}

function configure_nxengine() {
    addPort "$md_id" "cavestory" "Cave Story" "$md_inst/NXEngine.sh"
    
    ln -sf "$romdir/ports/CaveStory/data" "$md_inst/data"
    ln -sf "$romdir/ports/CaveStory/Doukutsu.exe" "$md_inst/Doukutsu.exe"
    chown -R $user:$user "$md_inst/data"
    chown -R $user:$user "$md_inst/Doukutsu.exe"

    cat >"$md_inst/NXEngine.sh" << _EOF_
#!/bin/bash
cd "$md_inst"
./nx
_EOF_
    chmod +x "$md_inst/NXEngine.sh"

}
