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

rp_module_id="lr-melonds"
rp_module_desc="NDS emu - MelonDS port for libretro"
rp_module_help="ROM Extensions: .nds .zip .7z\n\nCopy your Nintendo DS roms to $romdir/nds\n\nCopy firmware.bin, bios7.bin and bios9.bin to $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/melonDS/master/LICENSE"
rp_module_repo="git https://github.com/libretro/melonDS.git master"
rp_module_section="exp"
rp_module_flags=""

#function depends_lr-melonds() {
#    getDepends libwebkitgtk-3.0-dev libcurl4-gnutls-dev libpcap0.8-dev libsdl2-dev
#}

function sources_lr-melonds() {
    gitPullOrClone
}

function build_lr-melonds() {
    make clean
    make
    md_ret_require="$md_build/melonds_libretro.so"
}

function install_lr-melonds() {
    md_ret_files=(
        'melonds_libretro.so'
    )
}

function configure_lr-melonds() {
    mkRomDir "nds"
    ensureSystemretroconfig "nds"

    addEmulator 0 "$md_id" "nds" "$md_inst/melonds_libretro.so"
    addSystem "nds"
}
