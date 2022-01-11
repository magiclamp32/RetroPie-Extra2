#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-lutro"
rp_module_desc="Lua engine - lua game framework (WIP) for libretro following the LÖVE API"
rp_module_help="ROM Extensions: .lutro .lua\n\nCopy your Lua Lutro games to $romdir/lutro"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/libretro-lutro/master/LICENSE"
rp_module_repo="git https://github.com/libretro/libretro-lutro.git master"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-lutro() {
    gitPullOrClone
}

function build_lr-lutro() {
    make clean
    make
    md_ret_require="$md_build/lutro_libretro.so"
}

function install_lr-lutro() {
    md_ret_files=(
	'lutro_libretro.so'
    )
}

function configure_lr-lutro() {
    mkRomDir "lutro"
    ensureSystemretroconfig "lutro"
    
    addEmulator 1 "$md_id" "lutro" "$md_inst/lutro_libretro.so"
    addSystem "lutro"
}
