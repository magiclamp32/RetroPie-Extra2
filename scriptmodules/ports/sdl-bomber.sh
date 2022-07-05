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

rp_module_id="sdl-bomber"
rp_module_desc="sdl-bomber - Atomic Bomberman Clone"
rp_module_licence="GPL2 https://raw.githubusercontent.com/HerbFargus/SDL-Bomber/master/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_sdl-bomber() {
    getDepends libsdl1.2-dev
}

function sources_sdl-bomber() {
    gitPullOrClone "$md_build" https://github.com/HerbFargus/SDL-Bomber.git
}

function build_sdl-bomber() {
  make
  md_ret_require="$md_build"
}

function install_sdl-bomber() {
    md_ret_files=(
	'data'
	'bomber'
	'matcher'
    )
}

function configure_sdl-bomber() {
    setConfigRoot "ports"

    addPort "$md_id" "sdl-bomber" "SDL-Bomber" "pushd $md_inst; ./bomber; popd"
}
