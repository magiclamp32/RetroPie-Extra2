#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="burgerspace"
rp_module_desc="BurgerSpace - BurgerTime clone"
rp_module_menus="4+"
rp_module_flags="nobin !mali !x86"

function install_burgerspace() {
    aptInstall burgerspace
}

function configure_burgerspace() {
    mkRomDir "ports"

    #moveConfigDir "$home/.b" "$configdir/$md_id"
    addPort "$md_id" "burgerspace" "BurgerSpace" "burgerspace"
}
