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

rp_module_id="texmaster2009"
rp_module_desc="Texmaster2009 - Tetris TGM Clone"
rp_module_licence="Unknown/Freeware"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_texmaster2009() {
    getDepends wiringpi libsdl1.2-dev p7zip
}

function sources_texmaster2009() {
    wget -q http://mindflyer.net/tetris/texmaster/Texmaster2009-5.7z
    7zr x Texmaster2009-5.7z
    #tar xvfz Texmaster2009.rpi1-ARMv6.tar.gz
    cd Texmaster2009
    tar xvfz Texmaster2009.rpi2-ARMv7.tar.gz
}

function install_bin_texmaster2009() {
    md_ret_files=(
      'Texmaster2009/data'
      'Texmaster2009/Texmaster2009'
      'Texmaster2009/Texmaster2009.ini'
      'Texmaster2009/Texmaster2009.nv'
      'Texmaster2009/Texmaster2009.sav'
      'Texmaster2009/index.html'
      'Texmaster2009/html'
    )

}

function configure_texmaster2009() {
    sudo chmod -R 777 "$md_inst/data/"
    sudo chmod 777 "$md_inst"/Texmaster2009.*
    addPort "$md_id" "texmaster" "Texmaster - Tetris TGM Clone" "pushd $md_inst; $md_inst/Texmaster2009; popd"
}
