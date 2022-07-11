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

rp_module_id="lr-vitaquake2"
rp_module_desc="Quake 2 engine - vitaQuake II port for libretro"
rp_module_help="ROM Extensions: .pak"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/vitaquake2/libretro/LICENSE"
rp_module_repo="git https://github.com/libretro/vitaquake2.git libretro"
rp_module_section="exp"
rp_module_flags="!all 64bit"

function sources_lr-vitaquake2() {
    gitPullOrClone
}

function build_lr-vitaquake2() {
    mkdir -p "quake2-cores"
    local basegame
    local params=()
    for i in _ -rogue_ -xatrix_ -zaero_; do
        if [[ $i == -rogue_ ]]; then
	    j="rogue"
        elif [[ $i == -xatrix_ ]]; then
	    j="xatrix"
        elif [[ $i == -zaero_ ]]; then
	    j="zaero"
	fi
	params+=(basegame=$j)
	make "${params[@]}" clean
	make "${params[@]}"
	mv "vitaquake2"$i"libretro.so" "quake2-cores"
	md_ret_require="$md_build/quake2-cores/vitaquake2"$i"libretro.so"
    done
}

function install_lr-vitaquake2() {
    md_ret_files=(
	'LICENSE'
	'quake2-cores/vitaquake2_libretro.so'
	'quake2-cores/vitaquake2-rogue_libretro.so'
	'quake2-cores/vitaquake2-xatrix_libretro.so'
	'quake2-cores/vitaquake2-zaero_libretro.so'
    )
}

function add_games_lr-vitaquake2() {
    local cmd1="$md_inst/vitaquake2_libretro.so"
    local cmd2="$md_inst/vitaquake2-rogue_libretro.so"
    local cmd3="$md_inst/vitaquake2-xatrix_libretro.so"
    local cmd4="$md_inst/vitaquake2-zaero_libretro.so"
    declare -A games=(
	['baseq2/pak0']="Quake II"
        ['rogue/pak0']="Quake II - Ground Zero"
        ['xatrix/pak0']="Quake II - The Reckoning"
        ['zaero/pak0']="Quake II - Zaero"
    )

    local game
    local pak
    for game in "${!games[@]}"; do
        pak="$romdir/ports/quake2/baseq2/pak0.pak"
        if [[ -f "$pak" ]]; then
	    if [[ "$game" == "baseq2/pak0" ]]; then
                addPort "$md_id" "quake2" "${games[$game]}" "$cmd1" "$pak"
	    elif [[ "$game" == "rogue/pak0" ]]; then
                addPort "$md_id-rogue" "quake2" "${games[$game]}" "$cmd2" "$pak"
	    elif [[ "$game" == "xatrix/pak0" ]]; then
                addPort "$md_id-xatrix" "quake2" "${games[$game]}" "$cmd3" "$pak"
	    elif [[ "$game" == "zaero/pak0" ]]; then
                addPort "$md_id-zaero" "quake2" "${games[$game]}" "$cmd4" "$pak"
	    fi
        fi
    done
}

function configure_lr-vitaquake2() {
    setConfigRoot "ports"
    mkRomDir "ports/quake2"

    [[ "$md_mode" == "install" ]] && add_games_lr-vitaquake2

    ensureSystemretroconfig "ports/quake2"

    chown $user:$user "ports/quake2"
}
