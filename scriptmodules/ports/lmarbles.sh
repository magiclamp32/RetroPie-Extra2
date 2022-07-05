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

rp_module_id="lmarbles"
rp_module_desc="lmarbles - Open Source Atomix game"
rp_module_licence="GPL2 https://sourceforge.net/p/lgames/code/HEAD/tree/trunk/lmarbles/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

function install_bin_lmarbles() {
     aptInstall lmarbles
}

function configure_lmarbles() {
    mkRomDir "ports"
    moveConfigFile "$home/.lgames/lmarbles.conf" "$md_conf_root/lmarbles/lmarbles.conf"
    addPort "$md_id" "lmarbles" "lmarbles - Open Source Atomix game" "/usr/games/lmarbles"
}
