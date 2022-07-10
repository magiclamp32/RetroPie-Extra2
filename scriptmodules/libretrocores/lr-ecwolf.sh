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

rp_module_id="lr-ecwolf"
rp_module_desc="Wolfestein 3D engine - ECWolf port based of Wolf4SDL for libretro"
rp_module_licence="GPL https://raw.githubusercontent.com/libretro/ecwolf/master/docs/license-gpl.txt"
rp_module_repo="git https://github.com/libretro/ecwolf.git master"
rp_module_section="exp"
rp_module_flags="sdl2"

function depends_lr-ecwolf() {
    depends_wolf4sdl
}

function sources_lr-ecwolf() {
    gitPullOrClone
}

function build_lr-ecwolf() {
    cd "src/libretro"
    make clean
    make
    md_ret_require="$md_build/src/libretro/ecwolf_libretro.so"
}

function install_lr-ecwolf() {
    md_ret_files=(
        'src/libretro/ecwolf_libretro.so'
    )
}

function game_data_lr-ecwolf() {
    local __archive_url__="https://buildbot.libretro.com/assets/cores/Wolfenstein%203D"
    local dest="$romdir/ports/wolf3d"
    mkUserDir "$dest"
    if [[ ! -f "$dest/ecwolf.pk3" ]]; then
        # Get ECWolf System File
        download "$__archive_url__/ecwolf.pk3" "$dest/ecwolf.pk3"
    fi

    if [[ ! -f "$dest/vswap.wl6" && ! -f "$dest/vswap.wl1" ]]; then
        cd "$__tmpdir"
        # Get shareware game data
        downloadAndExtract "http://maniacsvault.net/ecwolf/files/shareware/wolf3d14.zip" "$romdir/ports/wolf3d" -j -LL
    fi
    if [[ ! -f "$dest/vswap.sdm" && ! -f "$dest/vswap.sod" ]]; then
        cd "$__tmpdir"
        # Get shareware game data
        downloadAndExtract "http://maniacsvault.net/ecwolf/files/shareware/soddemo.zip" "$romdir/ports/wolf3d" -j -LL
    fi

    chown -R $user:$user "$dest"
}

function _add_games_lr-ecwolf(){
    local port="$2"
    local cmd="$1"
    local game
    local doswad
    local wad

    declare -A -g games=(
        ['vswap.wl1']="Wolfenstein 3D (Demo)"
        ['vswap.wl6']="Wolfenstein 3D"
        ['vswap.sod']="Wolfenstein 3D - Spear of Destiny"
        ['vswap.sd1']="Wolfenstein 3D - Spear of Destiny (Ep 1)"
        ['vswap.sd2']="Wolfenstein 3D - Spear of Destiny (Ep 2)"
        ['vswap.sd3']="Wolfenstein 3D - Spear of Destiny (Ep 3)"
        ['vswap.sdm']="Wolfenstein 3D - Spear of Destiny (Demo)"
        ['vswap.n3d']="Wolfenstein 3D - Super Noah’s Ark 3D"
    )

    for game in "${!games[@]}"; do
        doswad="$romdir/ports/wolf3d/${game^^}"
        wad="$romdir/ports/wolf3d/$game"
        if [[ -f "$doswad" ]]; then
            mv "$doswad" "$wad"
        fi
        if [[ -f "$wad" ]]; then
            addPort "$md_id" "$port" "${games[$game]}" "$cmd" "$wad"
        fi
    done
}

function add_games_lr-ecwolf() {
    _add_games_lr-ecwolf "$md_inst/ecwolf_libretro.so"
}

function configure_lr-ecwolf() {
    setConfigRoot "ports"

    mkRomDir "ports/wolf3d"
    ensureSystemretroconfig "ports/wolf3d"

    [[ "$md_mode" == "install" ]] && game_data_lr-ecwolf

    add_games_lr-ecwolf
}
