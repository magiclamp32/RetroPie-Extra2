#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-citra"
rp_module_desc="3DS emulator - Citra port for libretro"
rp_module_help="OpenGL >= 3.3 is required.\n\nROM Extensions: .3ds .3dsx .elf .axf .cci .cxi .app\n\nCopy your Nintendo 3DS roms to $romdir/3ds"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/citra/master/license.txt"
rp_module_repo="git https://github.com/libretro/citra.git master"
rp_module_section="exp"
rp_module_flags="!all 64bit"

function depends_lr-citra() {
    getDepends cmake
}

function sources_lr-citra() {
    gitPullOrClone
}

function build_lr-citra() {
    mkdir build  && cd build
    cmake .. -DENABLE_LIBRETRO=1 -DLIBRETRO_STATIC=1 -DENABLE_SDL2=0 -DENABLE_QT=0 -DCMAKE_BUILD_TYPE="Release" -DENABLE_WEB_SERVICE=0 
    make
    md_ret_require="$md_build/build/src/citra_libretro/citra_libretro.so"
}

function install_lr-citra() {
    md_ret_files=(
        'build/src/citra_libretro/citra_libretro.so'
    )
}

function configure_lr-citra() {
    mkRomDir "3ds"
    ensureSystemretroconfig "3ds"

    addEmulator 1 "$md_id" "3ds" "$md_inst/citra_libretro.so"
    addSystem "3ds"
}
