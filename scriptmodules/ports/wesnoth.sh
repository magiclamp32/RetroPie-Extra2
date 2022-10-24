#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="wesnoth"
rp_module_desc="Wesnoth - turn-based strategy game"
rp_module_licence="GPL2 https://raw.githubusercontent.com/wesnoth/wesnoth/master/COPYING"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_wesnoth() {
    getDepends xorg timidity freepats matchbox
}

function install_bin_wesnoth() {
    aptInstall wesnoth
}

function configure_wesnoth() {
    local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.wesnoth" "$md_conf_root/$md_id"

    cat > "$script" << _EOF_
#!/bin/bash
"/usr/games/wesnoth"
_EOF_

    chmod +x "$script"
    addPort "$md_id" "wesnoth" "The Battle for Wesnoth" "XINIT:$script"
}