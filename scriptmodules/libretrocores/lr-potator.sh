#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-potator"
rp_module_desc="Watara Supervision emulator based on Normmatt version - Potator port for libretro"
rp_module_help="ROM Extensions: .sv .zip .7z\n\nCopy your Watara Supervision roms to $romdir/svision"
rp_module_licence="Unl https://raw.githubusercontent.com/libretro/potator/master/LICENSE"
rp_module_section="exp"
rp_module_repo="git https://github.com/libretro/potator.git master"
rp_module_flags="" 

function sources_lr-potator() {
    gitPullOrClone
}

function build_lr-potator() {
    cd "platform/libretro"
    make clean
    make 
    md_ret_require="$md_build/platform/libretro/potator_libretro.so"
}

function install_lr-potator() {
    md_ret_files=(
	'LICENSE'
	'platform/libretro/potator_libretro.so'
    )
}

function configure_lr-potator() {
    local system
    for system in svision; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"

        addEmulator 1 "$md_id" "$system" "$md_inst/potator_libretro.so"
        addSystem "$system"
    done
}
