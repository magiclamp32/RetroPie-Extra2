#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="thunderbird"
rp_module_desc="Thunderbird — Software made to make email easier"
rp_module_licence="MPL2 https://www.mozilla.org/media/MPL/2.0/index.815ca599c9df.txt"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_thunderbird() {
    getDepends xorg matchbox
}

function install_bin_thunderbird() {
    aptInstall thunderbird
}

function configure_thunderbird() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.mozilla" "$md_conf_root/$md_id"
    cat >"$md_inst/thunderbird.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/thunderbird
_EOF_
    chmod +x "$md_inst/thunderbird.sh"
    
     addPort "$md_id" "thunderbird" "Mozilla - Thunderbird - Email Client" "XINIT: $md_inst/thunderbird.sh"
}
