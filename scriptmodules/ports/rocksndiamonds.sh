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

rp_module_id="rocksndiamonds"
rp_module_desc="Rocks'n'Diamonds - Emerald Mine Clone"
rp_module_licence=" GNU https://git.artsoft.org/?p=rocksndiamonds.git;a=blob;f=COPYING;hb=HEAD"
rp_module_repo="file https://www.artsoft.org/RELEASES/unix/rocksndiamonds/rocksndiamonds-4.2.3.1.tar.gz"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_rocksndiamonds() {
    getDepends libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-net-dev
}

function sources_rocksndiamonds() {
    downloadAndExtract "$md_repo_url" "$md_build" "--strip-components=1"
}

function build_rocksndiamonds() {
    make
    md_ret_require="rocksndiamonds"
}

function install_rocksndiamonds() {
    md_ret_files=(
        'graphics'
        'levels'
        'music'
        'sounds'
        'COPYING'
        'CREDITS'
        'rocksndiamonds'
)
}

function configure_rocksndiamonds() {
    addPort "$md_id" "rocksndiamonds" "Rocks n' Diamonds" "$md_inst/rocksndiamonds"
    mkRomDir "ports/rocksndiamonds"
    moveConfigDir "$home/.rocksndiamonds" "$md_conf_root/rocksndiamonds"
}
