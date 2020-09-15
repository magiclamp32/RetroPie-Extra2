#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vecx"
rp_module_desc="lr-vecx - vecx port for libretro - A Vectrex emulator."
rp_module_help="ROM Extension: .cdg\n\nCopy your .vec/.gam/.bin ROMs into $romdir/vectrex."
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/libretro-vecx/master/LICENSE"
rp_module_section="exp"

function sources_lr-vecx() {
    gitPullOrClone "$md_build" https://github.com/grolliffe/libretro-vecx.git
}

function build_lr-vecx() {
    rpSwap on 750
    make clean
    local params=()
    isPlatform "arm" && params+=("ARM=1")
    make ARCH="$CFLAGS" "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/vecx_libretro.so"
}

function install_lr-vecx() {
    md_ret_files=(
        'vecx_libretro.so'
        'README.md'
    )
}

function configure_lr-vecx() {
    mkRomDir "$romdir/vectrex"

    addEmulator 0 "$md_id" "vectrex" "$md_inst/vecx_libretro.so" 
    addSystem "vectrex" "Vectrex" ".7z .vec .gam .bin .zip .7Z .VEC .GAM .BIN .ZIP"
}
