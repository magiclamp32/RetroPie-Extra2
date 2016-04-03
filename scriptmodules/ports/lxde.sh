#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lxde"
rp_module_desc="LXDE - Desktop Environment for the Raspberry Pi"
rp_module_menus="4+"
rp_module_flags="!x86 !mali"

function install_lxde() {
    aptInstall lxde xorg policykit-1 raspberrypi-ui-mods
}

function configure_lxde() {
    addPort "$md_id" "lxde" "DESKTOP" "startx"
    
    # Enable Autostart into EmulationStation by resetting the boot sequence to log autologin to console
    raspi-config nonint do_boot_behaviour_new B2
}
