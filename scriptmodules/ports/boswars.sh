#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="boswars"
rp_module_desc="boswars - Battle of Survival - is a futuristic real-time strategy game"
rp_module_licence="GNU https://libregamewiki.org/GNU_General_Public_License"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_boswars() {
    getDepends xorg
}

function install_bin_boswars() {
    aptInstall boswars
}

function configure_boswars() {
    local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.boswars" "$md_conf_root/$md_id"

    cat > "$script" << _EOF_
#!/bin/bash
"/usr/games/boswars"
_EOF_

    chmod +x "$script"
    addPort "$md_id" "boswars" "Battle of Survival" "XINIT:$script"
}