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

rp_module_id="lgeneral"
rp_module_desc="lgeneral - Open Source strategy game"
rp_module_licence="GPL2 https://sourceforge.net/p/lgames/code/HEAD/tree/trunk/lgeneral/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

function install_bin_lgeneral() {
     aptInstall lgeneral
}

function configure_lgeneral() {
    mkRomDir "ports"
    moveConfigFile "$home/.lgames/lgeneral.conf" "$md_conf_root/lgeneral/lgeneral.conf"
    addPort "$md_id" "lgeneral" "lgeneral - Open Source strategy game" "/usr/games/lgeneral"
}
