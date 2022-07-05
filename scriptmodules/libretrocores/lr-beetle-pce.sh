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

rp_module_id="lr-beetle-pce"
rp_module_desc="PCEngine emu - Mednafen PCE port for libretro"
rp_module_help="ROM Extensions: .pce .ccd .cue .zip\n\nCopy your PC Engine / TurboGrafx roms to $romdir/pcengine\n\nCopy the required BIOS file syscard3.pce to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-pce-libretro/master/COPYING"
rp_module_repo="git https://github.com/libretro/beetle-pce-libretro.git master"
rp_module_section="exp"

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
