#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="mypaint"
rp_module_desc="mypaint easy-to-use painting program"
rp_module_licence="mypaint.org"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_mypaint() {
    getDepends xorg matchbox
}

function install_bin_mypaint() {
    aptInstall mypaint
}

function configure_mypaint() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/mypaint.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/mypaint +set in_tty 0
_EOF_
    chmod +x "$md_inst/mypaint.sh"
    
     addPort "$md_id" "mypaint" "MyPaint easy-to-use painting program" "XINIT: $md_inst/mypaint.sh"
}
