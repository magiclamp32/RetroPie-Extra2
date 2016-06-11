#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="mayhem"
rp_module_desc="Mayhem - Remake of Amiga Game"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_mayhem() {
    getDepends liballegro4.4 liballegro4-dev xinit
}

function sources_mayhem() {
    gitPullOrClone "$md_build" https://github.com/martinohanlon/mayhem-pi
}

function build_mayhem() {
  make clean
  make
  md_ret_require="$md_build/mayhem2-pi"
}

function install_mayhem() {
    md_ret_files=(
	'mayhem2-pi'
	'sfx_boom.WAV'
        'sfx_loop_refuel.WAV'
        'sfx_loop_shield.WAV'
        'sfx_loop_thrust.WAV'
        'sfx_rebound.WAV'
        'sfx_shoot.WAV'
        'ship1_256c.bmp'
        'ship1_shield_256c.bmp'
        'ship1_thrust_256c.bmp'
        'ship2_256c.bmp'
        'ship2_shield_256c.bmp'
        'ship2_thrust_256c.bmp'
        'ship3_256c.bmp'
        'ship3_shield_256c.bmp'
        'ship3_thrust_256c.bmp'
        'ship4_256c.bmp'
        'ship4_shield_256c.bmp'
        'ship4_thrust_256c.bmp'
        'Mayhem_Level1_Map_256c.bmp'
        'Mayhem_Level2_Map_256c.bmp'
        'Mayhem_Level3_Map_256c.bmp'
        'Mini_map1.bmp'
        'Mini_map2.bmp'
        'Mini_map3.bmp'
        'Option.bmp'
        'Sprite_explosion.bmp'
        'intro_logo.bmp'
        'mayhem.jpg'
        'start'
    )
}

function configure_mayhem() {
    mkRomDir "ports"
    addPort "$md_id" "mayhem" "Mayhem - Remake of Amiga Game" "pushd $md_inst; ./start; popd"
}
