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

rp_module_id="vorton"
rp_module_desc="Vorton - Highway Encounter Remake"
rp_module_licence="GPL2 https://raw.githubusercontent.com/zerojay/vorton/master/LICENSE"
rp_module_repo="git https://github.com/zerojay/vorton.git"
rp_module_section="exp"
rp_module_flags="!x11 !mali"

function depends_vorton() {
    getDepends libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev unzip
}

function sources_vorton() {
    gitPullOrClone
}

function build_vorton() {
    make clean
    make -f Makefile.linux
    md_ret_require="$md_build/vorton"
}

function install_vorton() {
    md_ret_files=(
       'data'
       'vorton'
    )
}

function configure_vorton() {
    mkRomDir "ports"

    addPort "$md_id" "vorton" "Vorton - Highway Encounter Remake" "pushd $md_inst; $md_inst/vorton; popd"
}
