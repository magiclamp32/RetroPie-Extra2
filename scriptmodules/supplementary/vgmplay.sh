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

rp_module_id="vgmplay"
rp_module_desc="vgmplay - Music Player"
rp_module_help="This application must be run from the command line. Add your .vgm and .vgz files to $home/vgm."
rp_module_section="exp"
rp_module_flags="!x86"

function depends_vgmplay() {
    getDepends make gcc zlib1g-dev libao-dev
}

function sources_vgmplay() {
    git clone https://github.com/it-s/vgmplay.git
}

function build_vgmplay() {
    cd "$md_build/vgmplay/VGMPlay"
    make
    md_ret_require="$md_build/vgmplay/VGMPlay/vgmplay"
}

function install_vgmplay() {
    md_ret_files=(
        'vgmplay/VGMPlay/vgmplay'
        'vgmplay/VGMPlay/VGMPlay.ini'
    )
}

function configure_vgmplay() {
    mkdir -p "$home/vgm"
    moveConfigFile "$md_inst/VGMPlay.ini" "$md_conf_root/$md_id/VGMPlay.ini"

    addPort "$md_id" "vgmplay" "vgmplay - Music Player" "$md_inst/vgmplay"
}
