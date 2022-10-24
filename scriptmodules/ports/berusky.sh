#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="berusky"
rp_module_desc="berusky - Advanced sokoban clone with nice graphics"
rp_module_licence="GNU https://libregamewiki.org/GNU_General_Public_License"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_berusky() {
    getDepends xorg matchbox-window-manager
}

function install_bin_berusky() {
    aptInstall berusky
}

function configure_berusky() {
    local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.berusky" "$md_conf_root/$md_id"

    cat > "$script" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
"/usr/games/berusky" \$*
_EOF_

    chmod +x "$script"
    addPort "$md_id" "berusky" "Berusky - Sokoban clone" "XINIT:$script"
}