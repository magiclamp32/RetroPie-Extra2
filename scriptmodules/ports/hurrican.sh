#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="hurrican"
rp_module_desc="Hurrican - Turrican Clone"
rp_module_menus="4+"
rp_module_flags="!mali !rpi"

function depends_hurrican() {
    local depends=(subversion libsdl-image1.2-dev libmodplug-dev)
    if [[ "$__raspbian_ver" -lt 8 ]]; then
        depends+=(libsdl1.2-dev libsdl-mixer1.2-dev)
    else
        depends+=(libsdl2-dev libsdl2-mixer-dev)
    fi
    getDepends "${depends[@]}"
}

function sources_hurrican() {
    svn checkout svn://svn.code.sf.net/p/hurrican/code/trunk "$md_build"
}

function build_hurrican() {
    cd $md_build/Hurrican/src/
    make
    md_ret_require="$md_build"
}

function install_hurrican() {
    md_ret_files=(
        '/Hurrican/hurricanlinux'
        '/Hurrican/data'
        '/Hurrican/lang'
        '/Hurrican/splashscreen.bmp'
        '/Editor/maps' 
        '/Editor/Gfx'     
    )
}

function configure_hurrican() {
    addPort "$md_id" "hurrican" "Hurrican" "pushd $md_inst; $md_inst/hurricanlinux; popd"

    mkRomDir "ports"

    moveConfigDir "$home/.hurrican" "$md_conf_root/hurrican"
}
