#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-sameboy"
rp_module_desc="Game Boy (Color) emulator - SameBoy Port for libretro"
rp_module_help="ROM Extensions: .gb .gbc .zip .7z\n\nCopy your Gameboy roms to $romdir/gb.\nCopy your Gameboy Color roms to $romdir/gbc.\n\nCopy the required BIOS files dmg_boot.bin (gb BIOS) and cgb_boot.bin (gbc BIOS) to $biosdir"
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/SameBoy/buildbot/LICENSE"
rp_module_repo="git https://github.com/libretro/SameBoy.git buildbot"
rp_module_section="exp x86=opt"

function depends_lr-sameboy() {
    # For lr-Sameboy
    local depends=(clang libsdl2-dev)
    # For rgbds: 
    #depends+=(byacc flex libpng-dev)
    getDepends "${depends[@]}"
}

function sources_lr-sameboy() {
    gitPullOrClone
}

function build_lr-sameboy() {
    make clean
    CC=clang make -f Makefile libretro
    md_ret_require="$md_build/libretro/sameboy_libretro.so"
}

function install_lr-sameboy() {
    md_ret_files=(
	'libretro/sameboy_libretro.so'
    )
}

function configure_lr-sameboy() {
    local system
    for system in gb gbc; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"

        local def=0
        isPlatform "armv6" && def=1

        addEmulator 1 "$md_id" "$system" "$md_inst/sameboy_libretro.so"
        addSystem "$system"
    done
}
