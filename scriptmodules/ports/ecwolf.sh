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

rp_module_id="ecwolf"
rp_module_desc="ECWolf - ECWolf is an advanced source port for Wolfenstein 3D, Spear of Destiny, and Super 3D Noah's Ark based off of the Wolf4SDL code base. It also supports mods from .pk3 files."
rp_module_licence="GPL2 https://bitbucket.org/ecwolf/ecwolf/raw/5065aaefe055bff5a8bb8396f7f2ca5f2e2cab27/docs/license-gpl.txt"
rp_module_help="For registered versions, replace the shareware files by adding your full Wolf3d, Spear3D 1.4 version game files to $romdir/ports/wolf3d/."
rp_module_repo="git https://bitbucket.org/ecwolf/ecwolf master c85dbd3"
rp_module_section="exp"
rp_module_flags=""

function depends_ecwolf() {
    getDepends libsdl2-dev libsdl2-mixer-dev libsdl2-net-dev zlib1g-dev libsdl1.2-dev libsdl-mixer1.2-dev libsdl-net1.2-dev rename
}

function sources_ecwolf() {
    gitPullOrClone
    # add Escape to controller bindable keys to access main menu
    applyPatch "$md_data/01_keyboard_patch.diff"
}

function build_ecwolf() {
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DGPL=ON ..
    make
    md_ret_require="$md_build/build/ecwolf"
}

function install_ecwolf() {
    md_ret_files=(
       'build/ecwolf'
       'build/ecwolf.pk3'
    )
}

function game_data_ecwolf() {
    game_data_wolf4sdl
}

function add_games_ecwolf(){
    declare -A games_wolf4sdl=(
        ['vswap.wl1']="Wolfenstein 3D demo"
        ['vswap.wl6']="Wolfenstein 3D"
        ['vswap.sod']="Wolfenstein 3D - Spear of Destiny"
        ['vswap.sd2']="Wolfenstein 3D - Spear of Destiny Ep 2"
        ['vswap.sd3']="Wolfenstein 3D - Spear of Destiny Ep 3"
        ['vswap.sdm']="Wolfenstein 3D - Spear of Destiny Demo"
        ['vswap.n3d']="Wolfenstein 3D - Super 3D Noah’s Ark"
    )

    add_ports_wolf4sdl "$md_inst/$md_id.sh %ROM% --fullscreen --res %XRES% %YRES%" "wolf3d"
}

function configure_ecwolf() {
    local script="$md_inst/$md_id.sh"

    mkRomDir "ports/wolf3d"

    if [[ "$md_mode" == "install" ]]; then
        game_data_ecwolf
        cat > "$script" << _EOF_
#!/bin/bash

rom="\$1"
path="\${rom%/*}"
ext="\${rom##*.}"
shift

pushd "\$path"
"$md_inst/ecwolf" --data "\$ext" "\$@"
popd
_EOF_

        chmod +x "$script"
    fi

    add_games_ecwolf

    moveConfigDir "$home/.local/share/ecwolf" "$md_conf_root/wolf3d/ecwolf"
    moveConfigDir "$home/.config/ecwolf" "$md_conf_root/wolf3d/ecwolf"
}
