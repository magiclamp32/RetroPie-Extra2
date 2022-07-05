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
 
rp_module_id="warmux"
rp_module_desc="Warmux - Worms Clone"
rp_module_licence="GPL2 https://raw.githubusercontent.com/yeKcim/warmux/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!mali"
 
function install_bin_warmux() {
    aptInstall warmux
}
 
function configure_warmux() {
    addPort "$md_id" "warmux" "warmux" "/usr/games/warmux"
}
