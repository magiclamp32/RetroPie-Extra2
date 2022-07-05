#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://github.com/Exarkuniv/RetroPie-Extra/blob/master/LICENSE
#

rp_module_id="wizznic"
rp_module_desc="Awesome Puzzle Game"
rp_module_licence="http://wizznic.org/"
rp_module_section="exp"
rp_module_flags="!mali !x86"


function install_bin_wizznic() {
    aptInstall wizznic
}

function configure_wizznic() {
    mkRomDir "ports"
    touch "$md_inst/settings.ini"
    moveConfigFile "$md_inst/settings.ini" "$md_conf_root/$md_id/settings.ini"
    chown -R $user:$user "$md_conf_root/$md_id"
    addPort "$md_id" "wizznic" "Wizznic - Puzznic clone" "pushd $md_inst; $md_inst/wizznic -sw; popd"
}
