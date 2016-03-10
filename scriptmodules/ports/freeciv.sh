#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="freeciv"
rp_module_desc="freeciv - Open Source Civilization game"
rp_module_menus="4+"
rp_module_flags="nobin !mali !x86"

function depends_freeciv() {
    # Using xorg/xinit fixes issue where game couldn't get past opening menu screen.
    getDepends xorg
}

function install_freeciv() {
    
    aptInstall freeciv-client-sdl
}

function configure_freeciv() {
    mkRomDir "ports"
    moveConfigDir "$home/.freeciv" "$configdir/freeciv"
    moveConfigFile "$home/.freeciv-client-rc-2.4" "$configdir/freeciv"
    addPort "$md_id" "freeciv" "Freeciv" "xinit freeciv"
}
