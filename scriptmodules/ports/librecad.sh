#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="librecad"
rp_module_desc="librecad open-source 2d cad"
rp_module_licence="https://www.audacityteam.org"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_librecad() {
    getDepends xorg matchbox
}

function install_bin_librecad() {
    aptInstall librecad
}

function configure_librecad() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/librecad.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/librecad
_EOF_
    chmod +x "$md_inst/librecad.sh"
    
     addPort "$md_id" "librecad" "LibreCAD - Free Open Source 2D CAD" "XINIT: $md_inst/librecad.sh"
}
