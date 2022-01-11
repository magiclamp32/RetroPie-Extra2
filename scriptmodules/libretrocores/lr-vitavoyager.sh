#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-vitavoyager"
rp_module_desc="Star Trek Voyager Elite Force Holomatch engine - Lilium Voyager (fork of ioquake3) port for libretro"
rp_module_help="ROM Extensions: .pk3"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vitaVoyager/libretro/COPYING.txt"
rp_module_repo="git https://github.com/libretro/vitaVoyager.git libretro"
rp_module_section="exp"
rp_module_flags="!all 64bit"

function sources_lr-vitavoyager() {
    gitPullOrClone
}

function build_lr-vitavoyager() {
    make clean
    make
    md_ret_require="$md_build/vitavoyager_libretro.so"
}

function install_lr-vitavoyager() {
    md_ret_files=(
	'data/voyager/baseEF'
        'COPYING.txt'
        'vitavoyager_libretro.so'
    )
}

function _add_games_lr-vitavoyager() {
    local cmd="$1"
    declare -A games=(
	['baseEF']="Star Trek Voyager - Elite Force Holomatch"
    )
    local dir
    local pk3
    for dir in "${!games[@]}"; do
        pk3="$romdir/ports/voyager/$dir/pak92.pk3"
        if [[ -f "$pk3" ]]; then
            addPort "$md_id" "voyager" "${games[$dir]}" "$cmd" "$pk3"
        fi
    done
}

function add_games_lr-vitavoyager() {
    _add_games_lr-vitavoyager "$md_inst/vitavoyager_libretro.so"
}

function configure_lr-vitavoyager() {
    setConfigRoot "ports"
    mkRomDir "ports/voyager"
    
    if [[ ! -f "$romdir/ports/voyager/baseEF/pak92.pk3" ]]; then
	cp -Rv "$md_inst/baseEF" "$romdir/ports/voyager"
	chown $user:$user -R "$romdir/ports/voyager/baseEF/"*
    fi

    [[ "$md_mode" == "install" ]] && add_games_lr-vitavoyager

    ensureSystemretroconfig "ports/voyager"
}
