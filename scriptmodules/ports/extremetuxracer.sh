#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="extremetuxracer"
rp_module_desc="ExtremeTuxRacer - Linux verion of Mario cart"
rp_module_licence="GPL2 https://sourceforge.net/p/extremetuxracer/code/HEAD/tree/trunk/COPYING?format=raw"
rp_module_section="exp"
rp_module_flags="!mali !x86"
 
function depends_extremetuxracer() {
    getDepends xorg
}


function install_bin_extremetuxracer() {
    aptInstall extremetuxracer
}
 
function configure_extremetuxracer() {
    local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.etracer" "$md_conf_root/$md_id"

    cat > "$script" << _EOF_
#!/bin/bash
pushd "$md_inst"
"/usr/games/etr" \$*
popd
_EOF_

    chmod +x "$script"
    addPort "$md_id" "extremetuxracer" "ExtremeTuxRacer" "XINIT:$script"
}