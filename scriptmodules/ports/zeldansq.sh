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

rp_module_id="zeldansq"
rp_module_desc="zeldansq - Zelda Navi's Quest fangame"
rp_module_licence="Unknown"
rp_module_help=""
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_zeldansq() {
    getDepends libsdl1.2-dev libsdl-gfx1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev unzip
}

function sources_zeldansq() {
    wget http://www.zeldaroth.fr/fichier/NSQ/linux/ZeldaNSQ-src-linux.zip
    unzip ZeldaNSQ-src-linux.zip
}

function build_zeldansq() {
    cd ZeldaNSQ-src-linux
    make
    md_ret_require="$md_build/ZeldaNSQ-src-linux/bin/Release/ZeldaNSQ"
}

function install_zeldansq() {
    md_ret_files=(
        'ZeldaNSQ-src-linux/bin/Release/ZeldaNSQ'
        'ZeldaNSQ-src-linux/data'
        'ZeldaNSQ-src-linux/config'
        'ZeldaNSQ-src-linux/saves'
    )
}

function configure_zeldansq() {
    mkRomDir "ports"
    chmod -R 777 "$md_inst/data"
    moveConfigDir "$md_inst/config" "$md_conf_root/$md_id/config"
    moveConfigDir "$md_inst/saves" "$md_conf_root/$md_id/saves"
    addPort "$md_id" "zeldansq" "zeldansq - Zelda Navi's Quest fangame" "pushd $md_inst; $md_inst/ZeldaNSQ; popd"
}
