#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="kraptor"
rp_module_desc="Shoot em up scroller game"
rp_module_licence="https://lutris.net/games/kraptor/"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_kraptor() {
    getDepends xorg matchbox
}

function install_bin_kraptor() {
    aptInstall kraptor
}

function configure_kraptor() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/kraptor.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/games/kraptor -windowscreen -1024x768
_EOF_
    chmod +x "$md_inst/kraptor.sh"
    
     addPort "$md_id" "kraptor" "Kraptor Shoot em up scroller game" "XINIT: $md_inst/kraptor.sh"
}
