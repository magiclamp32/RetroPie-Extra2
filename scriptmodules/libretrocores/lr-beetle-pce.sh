#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-beetle-pce"
rp_module_desc="PCEngine emu - Mednafen PCE port for libretro"
rp_module_help="ROM Extensions: .pce .ccd .cue .zip\n\nCopy your PC Engine / TurboGrafx roms to $romdir/pcengine\n\nCopy the required BIOS file syscard3.pce to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-pce-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-pce-libretro.git master"
rp_module_section="main"

function _update_hook_lr-beetle-pce() {
    # move from old location and update emulators.cfg
    renameModule "lr-mednafen-pce" "lr-beetle-pce"
}

function sources_lr-beetle-pce() {
    gitPullOrClone
}

function build_lr-beetle-pce() {
    make clean
    make
    md_ret_require="$md_build/mednafen_pce_libretro.so"
}

function install_lr-beetle-pce() {
    md_ret_files=(
        'mednafen_pce_libretro.so'
        'README.md'
    )
}

function configure_lr-beetle-pce() {
    mkRomDir "pcengine"
    ensureSystemretroconfig "pcengine"

    addEmulator 1 "$md_id" "pcengine" "$md_inst/mednafen_pce_libretro.so"
    addSystem "pcengine"
}
