#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="epiphany"
rp_module_desc="epiphany lightweight web browser"
rp_module_licence="https://github.com/GNOME/epiphany"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_epiphany() {
    getDepends xorg matchbox
}

function install_bin_epiphany() {
    aptInstall epiphany-browser
}

function configure_epiphany() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/epiphany.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/epiphany-browser +set in_tty 0
_EOF_
    chmod +x "$md_inst/epiphany.sh"
    
     addPort "$md_id" "epiphany" "Epiphany Lightweight Web Browser" "XINIT: $md_inst/epiphany.sh"
}
