#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://github.com/Exarkuniv/RetroPie-Extra/blob/master/LICENSE
#

rp_module_id="lr-gearcoleco"
rp_module_desc="ColecoVision emulator - GearColeco port for libretro."
rp_module_help="ROM Extensions: .col .cv .bin .rom .zip .7z\n\nCopy your ColecoVision roms to $romdir/coleco\n\nCopy the required BIOS files colecovision.rom to $biosdir"
rp_module_licence="GPL3 https://git.libretro.com/libretro/gearcoleco/blob/main/LICENSE"
rp_module_repo="git https://git.libretro.com/libretro/gearcoleco.git main"
rp_module_section="exp"
rp_module_flags=""

function sources_lr-gearcoleco() {
    gitPullOrClone
}

function build_lr-gearcoleco() {
    cd "platforms/libretro"
    make clean
    make
    md_ret_require="$md_build/platforms/libretro/gearcoleco_libretro.so"
}

function install_lr-gearcoleco() {
    md_ret_files=(
        'platforms/libretro/gearcoleco_libretro.so'
    )
}

function configure_lr-gearcoleco() {
    mkRomDir "coleco"
    ensureSystemretroconfig "coleco"

    addEmulator 1 "$md_id" "coleco" "$md_inst/gearcoleco_libretro.so"
    addSystem "coleco"
}
