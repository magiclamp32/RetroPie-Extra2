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

rp_module_id="ganbare"
rp_module_desc="Ganbare! Natsuke-San - 2D Platformer"
rp_module_repo="file https://dl.openhandhelds.org/gp2x/uploads/Home/gp2x%20-%20Games/Games%20-%20Freeware/Jump%20and%20Run/gnp_104.zip"
rp_module_section="exp"
rp_module_flags="!x11 !mali"

function depends_ganbare() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev unzip
}

function sources_ganbare() {
    downloadAndExtract "$md_repo_url" "$md_build"
}

function build_ganbare() {
    cd "$md_build/gnp_104"
    make clean
    make -f Makefile.linux
    md_ret_require="$md_build/gnp_104/gnp"
}

function install_ganbare() {
    md_ret_files=(
       'gnp_104/gnp'
       'gnp_104/data'
       'gnp_104/image'
       'gnp_104/replay'
       'gnp_104/save'
       'gnp_104/sound'
    )
}

function configure_ganbare() {
    mkRomDir "ports"
    moveConfigDir "$md_inst/save" "$md_conf_root/$md_id"
    chown -R $user:$user "$md_inst/save"

    addPort "$md_id" "ganbare" "Ganbare! Natsuke-San - 2D Platformer" "pushd $md_inst; $md_inst/gnp; popd"
}