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

rp_module_id="kaiten-patissier-ura"
rp_module_desc="Kaiten Patissier URA - RotateGear"
rp_module_section="exp"
rp_module_flags="!x11 !mali"

function depends_kaiten-patissier-ura() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev unzip
}

function sources_kaiten-patissier-ura() {
    wget -q https://dl.openhandhelds.org/gp2x/uploads/Home/gp2x%20-%20Games/Games%20-%20Freeware/Jump%20and%20Run/rg_ura_103.zip
    unzip rg_ura_103.zip
}

function build_kaiten-patissier-ura() {
    cd "$md_build/rg_ura_103/src"
    make clean
    make -f Makefile.linux
    md_ret_require="$md_build/rg_ura_103/src/RotateGear"
}

function install_kaiten-patissier-ura() {
    md_ret_files=(
       'rg_ura_103/src/RotateGear'
       'rg_ura_103/data'
       'rg_ura_103/image'
       'rg_ura_103/replay'
       'rg_ura_103/save'
       'rg_ura_103/sound'
    )
}

function configure_kaiten-patissier-ura() {
    mkRomDir "ports"
    moveConfigDir "$md_inst/save" "$md_conf_root/$md_id"
    chown -R $user:$user "$md_inst/save"

    addPort "$md_id" "kaiten-patissier-ura" "Kaiten Patissier URA - RotateGear" "pushd $md_inst; $md_inst/RotateGear; popd"
}
