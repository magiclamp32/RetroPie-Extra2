#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="fruity"
rp_module_desc="Fruity - inspired by the Kaiko classic GemX"
rp_module_licence="GPL2 https://www.retroguru.com/legal/"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_fruity() {
    getDepends libsdl-mixer1.2
}

function sources_fruity() {
    downloadAndExtract "https://www.retroguru.com/fruity/fruity-v.latest-raspberrypi.zip" "$md_inst"
}

function configure_fruity() {
  local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.fruity" "$md_conf_root/$md_id"

    cat > "$script" << _EOF_
#!/bin/bash
pushd "$md_inst"
"$md_inst/fruity_rpi" \$*
popd
_EOF_

    chmod +x "$script"
    addPort "$md_id" "fruity" "Fruity- Kaiko classic Gem'X clone" "XINIT:$script"

    chmod +x "$md_inst/fruity_rpi"
}