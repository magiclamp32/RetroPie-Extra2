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

rp_module_id="zeldapicross"
rp_module_desc="zeldapicross - Zelda themed Picross fangame"
rp_module_licence="Unknown"
rp_module_help="You may need to disable the number pad on your keyboard if you are having trouble getting past the initial game screen when launched."
rp_module_repo="git https://github.com/gameblabla/zeldapicross.git"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_zeldapicross() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev
}

function sources_zeldapicross() {
    gitPullOrClone
}

function build_zeldapicross() {
    make
    md_ret_require="$md_build/Zelda-Picross"
}

function install_zeldapicross() {
    md_ret_files=(
        'data'
        'Zelda-Picross'
    )
}

function configure_zeldapicross() {
    mkRomDir "ports"
    chmod -R 777 "$md_inst/data"
    moveConfigDir "$home/.config/zelda-picross" "$md_conf_root/$md_id/config"
    addPort "$md_id" "zeldapicross" "zeldapicross - Zelda themed Picross fangame" "pushd $md_inst; $md_inst/Zelda-Picross; popd"
}
