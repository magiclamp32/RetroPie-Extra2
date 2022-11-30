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

rp_module_id="vcmi"
rp_module_desc="Open-source engine for Heroes of Might and Magic III "
rp_module_help="Copy Data, Maps and Mp3 from Heroes III to roms/ports/vcmi"
rp_module_licence="GPL https://raw.githubusercontent.com/vcmi/vcmi/develop/license.txt"
rp_module_section="exp"
rp_module_flags="!mali"


function depends_vcmi() {
    getDepends cmake g++ libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev zlib1g-dev libavformat-dev libswscale-dev libboost-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libboost-program-options-dev libboost-locale-dev qtbase5-dev libtbb-dev libluajit-5.1-dev
}

function sources_vcmi() {
    git clone -b develop --depth 1 --recursive https://github.com/vcmi/vcmi.git
}

function build_vcmi() {
	mkdir build && cd build
	cmake ../vcmi -DENABLE_LAUNCHER=OFF -DENABLE_EDITOR=OFF -DENABLE_TEST=OFF -DM_DATA_DIR=/home/pi/RetroPie/roms/ports/vcmi   
	cmake --build . -- -j2
    md_ret_require=()
}

function install_vcmi() {
	md_ret_files=(/build/bin
    )
}

function configure_vcmi() {
   mkRomDir "/ports/$md_id"
   ln -sf "$romdir/ports/$md_id" "/home/pi/.local/share"
    moveConfigDir "/home/pi/.local/share/$md_id/Saves" "$md_conf_root/$md_id/Saves"
   addPort "$md_id" "vcmi" "Heroes of Might and Magic III" "$md_inst/bin/vcmiclient"
}