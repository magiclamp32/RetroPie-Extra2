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

rp_module_id="lr-vitaquake3"
rp_module_desc="Quake 3 engine - vitaQuake III (ioquake3) port for libretro"
rp_module_help="ROM Extensions: .pk3"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vitaquake3/libretro/LICENSE"
rp_module_repo="git https://github.com/libretro/vitaquake3.git libretro"
rp_module_section="exp"
rp_module_flags="!all 64bit"

function sources_lr-vitaquake3() {
    gitPullOrClone
}

function build_lr-vitaquake3() {
    make clean
    make
    md_ret_require="$md_build/vitaquake3_libretro.so"
}

function install_lr-vitaquake3() {
    md_ret_files=(
        'COPYING.txt'
        'vitaquake3_libretro.so'
	'data/ioq3'
	'data/openarena'
    )
}

function _add_games_lr-vitaquake3() {
    local cmd="$1"
    declare -A games=(
	['baseq3']="Quake III Arena"
	['baseoa']="OpenArena"
	['q3ut4']="Urban Terror"
	['baseq3r']="Q3Rally"
    )
    local dir
    local pk3
    local pk3_ut
    local pk3_rally
    for dir in "${!games[@]}"; do
        pk3="$romdir/ports/quake3/$dir/pak0.pk3"
	pk3_ut="$romdir/ports/quake3/$dir/zUrT43_001.pk3"
	pk3_rally="$romdir/ports/quake3/$dir/qvm.pk3"
        if [[ -f "$pk3" ]]; then
            addPort "$md_id" "quake3" "${games[$dir]}" "$cmd" "$pk3"
        elif  [[ -f "$pk3_ut" ]]; then
	    addPort "$md_id" "quake3" "${games[$dir]}" "$cmd" "$pk3_ut"
        elif  [[ -f "$pk3_rally" ]]; then
	    addPort "$md_id" "quake3" "${games[$dir]}" "$cmd" "$pk3_rally"
        fi
    done
}

function add_games_lr-vitaquake3() {
    _add_games_lr-vitaquake3 "$md_inst/vitaquake3_libretro.so"
}

function configure_lr-vitaquake3() {
    setConfigRoot "ports"
    mkRomDir "ports/quake3"
    mkRomDir "ports/quake3/baseq3r"

    mv "$md_inst/ioq3/"* "$md_inst/openarena/baseoa" "$romdir/ports/quake3"

    [[ "$md_mode" == "install" ]] && add_games_lr-vitaquake3

    ensureSystemretroconfig "ports/quake3"

    chown $user:$user -R "$romdir/ports/quake3"
}
