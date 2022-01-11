#!/usr/bin/env bash

# Adapted from ZeroJay's RetroPie-Extra
# https://github.com/zerojay/RetroPie-Extra

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="hcl"
rp_module_desc="Hydra Castle Labyrinth - a Metroidvania game created by E.Hashimoto (a.k.a. Buster)"
rp_module_help="Linux port by ptitSeb, based on the 3DS port by 4chan/anon\n\nMake sure to set the language to English from the options menu before playing. If you are experiencing slowdowns in game, make sure the xBRZ shader is turned off in the options menu."
rp_module_repo="git https://github.com/ptitSeb/hydracastlelabyrinth.git master e112bdb"
rp_module_licence="GPL2 https://github.com/ptitSeb/hydracastlelabyrinth/blob/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!x86"

function depends_hcl() {
    local depends=(cmake)
    if isPlatform "rpi4"; then
        depends+=(libsdl2-dev libsdl2-mixer-dev)
    else
        depends+=(libsdl1.2-dev libsdl-mixer1.2-dev)
    fi
    getDepends "${depends[@]}"
}

function sources_hcl() {
     gitPullOrClone
}

function build_hcl() {
    local params=(-DCMAKE_INSTALL_PREFIX:PATH="$md_inst")
    isPlatform "rpi4" && params+=(-DUSE_SDL2=ON)
    mkdir build && cd build
    cmake "${params[@]}" ..
    make
    md_ret_require="$md_build/build/hcl"
}

function install_hcl() {
    md_ret_files=(
        'build/hcl'
        'data'
    )
}

function configure_hcl() {
    addPort "$md_id" "hcl" "Hydra Castle Labrinth - Metroidvania Game" "pushd $md_inst; $md_inst/hcl -d; popd"
    mkRomDir "ports"
    moveConfigDir "$home/.hydracastlelabyrinth" "$md_conf_root/hcl"
}
