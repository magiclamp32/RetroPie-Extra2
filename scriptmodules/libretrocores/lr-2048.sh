#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-2048"
rp_module_desc="2048 engine - 2048 port for libretro"
rp_module_licence="Unl https://raw.githubusercontent.com/libretro/libretro-2048/master/COPYING"
rp_module_repo="git https://github.com/libretro/libretro-2048.git master"
rp_module_section="opt"
rp_module_flags=""

function sources_lr-2048() {
    gitPullOrClone
}

function build_lr-2048() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="$md_build/2048_libretro.so"
}

function install_lr-2048() {
    md_ret_files=(
        '2048_libretro.so'
    )
}

function configure_lr-2048() {
    setConfigRoot "ports"

    addPort "$md_id" "2048" "2048" "$md_inst/2048_libretro.so"

    ensureSystemretroconfig "ports/2048"
}
