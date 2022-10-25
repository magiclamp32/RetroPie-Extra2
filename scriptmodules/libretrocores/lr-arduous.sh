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

rp_module_id="lr-arduous"
rp_module_desc="ArduBoy emulator - arduous port for libretro"
rp_module_help="ROM Extensions: .hex .zip\n\nCopy your ArduBoy roms to $romdir/arduboy"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/arduous/master/license.txt"
rp_module_repo="git https://github.com/libretro/arduous main"
rp_module_section="exp"

function sources_lr-arduous() {
    gitPullOrClone
}

function build_lr-arduous() {
    cd build
    cmake ..
    make clean
    make
    md_ret_require="$md_build/build/arduous_libretro.so"
}

function install_lr-arduous() {
    md_ret_files=(
        'build/arduous_libretro.so'
    )
}

function configure_lr-arduous() {
    mkRomDir "arduboy"

    ensureSystemretroconfig "arduboy"
    
    # add the per system default settings
    iniConfig " = " '"' "$configdir/arduboy/retroarch.cfg"
    iniSet "video_shader" "$configdir/all/retroarch/shaders/handheld/gameboy/gb-pocket-shader.glslp"

    addEmulator 1 "$md_id" "arduboy" "$md_inst/arduous_libretro.so"

    addSystem "arduboy" "ArduBoy" ".hex .7z .zip"
}
    
