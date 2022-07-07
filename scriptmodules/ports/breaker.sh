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

rp_module_id="breaker"
rp_module_desc="breaker - Arkanoid Clone"
rp_module_licence="GPL2 https://ayera.dl.sourceforge.net/project/breaker10/source/GNU-GPL-2.0.txt"
rp_module_repo="file http://oldschoolprg.x10.mx/downloads/_sf_breaker_215.tar.gz"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_breaker() {
    getDepends libsdl2-dev unzip xorg xinit x11-xserver-utils
}

function sources_breaker() {
    downloadAndExtract "$md_repo_url" "$md_build"
}

function build_breaker() {
  cd "$md_build/source"
  sed -i "s/-lSDL/-lSDL -lm/" "$md_build/source/Makefile"
  make
  md_ret_require="$md_build/source/breaker"
}

function install_breaker() {
    md_ret_files=(
	'source/breaker'
	'source/gfx'
    )
}

function configure_breaker() {
    mkRomDir "ports"
    addPort "$md_id" "breaker" "breaker - Arkanoid Clone" "XINIT: pushd $md_inst; ./breaker; popd"
}
