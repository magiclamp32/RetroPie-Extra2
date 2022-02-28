#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="libreoffice"
rp_module_desc="Open source office suite"
rp_module_licence="https://www.libreoffice.org"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_libreoffice() {
    getDepends xorg matchbox
}

function install_bin_libreoffice() {
    aptInstall libreoffice
}

function configure_libreoffice() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/libreoffice.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/libreoffice
_EOF_
    chmod +x "$md_inst/libreoffice.sh"
    
     addPort "$md_id" "libreoffice" "LibreOffice Open Source office suite" "XINIT: $md_inst/libreoffice.sh"
}
