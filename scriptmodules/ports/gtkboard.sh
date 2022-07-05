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

rp_module_id="gtkboard"
rp_module_desc="Board games system"
rp_module_licence="gtkboard.sourceforge.net"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_gtkboard() {
    getDepends xorg matchbox
}

function install_bin_gtkboard() {
    aptInstall gtkboard
}

function configure_gtkboard() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/gtkboard.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/games/gtkboard
_EOF_
    chmod +x "$md_inst/gtkboard.sh"
    
     addPort "$md_id" "gtkboard" "Gtkboard Board games system" "XINIT: $md_inst/gtkboard.sh"
}
