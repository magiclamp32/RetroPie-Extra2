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

rp_module_id="lbreakout2"
rp_module_desc="lbreakout2 - Open Source Breakout game"
rp_module_licence="GPL2 https://sourceforge.net/p/lgames/code/HEAD/tree/trunk/lbreakout2/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_lbreakout2() {
    getDepends xorg matchbox
}

function install_bin_lbreakout2() {
    aptInstall lbreakout2
}

function configure_lbreakout2() {
    mkRomDir "ports"
    moveConfigFile "$home/.lgames/lbreakout2.conf" "$md_conf_root/lbreakout2/lbreakout2.conf"
    cat >"$md_inst/lbreakout2.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/games/lbreakout2 -fullscreen -1024x768
_EOF_
    chmod +x "$md_inst/lbreakout2.sh"
    addPort "$md_id" "lbreakout2" "lbreakout2 - Open Source Breakout game" "XINIT: $md_inst/lbreakout2.sh"
}

