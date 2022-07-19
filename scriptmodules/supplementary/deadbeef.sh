#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="deadbeef"
rp_module_desc="deadbeef - Music Player"
rp_module_licence="MIT https://raw.githubusercontent.com/Alexey-Yakovenko/deadbeef/master/COPYING"
rp_module_repo="git https://github.com/Alexey-Yakovenko/deadbeef.git"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_deadbeef() {
    getDepends git autopoint libtool intltool libgtk-3-dev libjansson-dev automake autoconf xdg-utils matchbox xorg
}

function sources_deadbeef() {
    gitPullOrClone
}

function build_deadbeef() {
    ./autogen.sh
    ./configure --prefix="$md_inst"
    make
}

function install_deadbeef() {
    cd "$md_build/deadbeef"
    make install
}

function configure_deadbeef() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config/$md_id" "$md_conf_root/$md_id"

    cat >"$md_inst/deadbeef.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
"$md_inst/bin/deadbeef"
_EOF_
    chmod +x "$md_inst/deadbeef.sh"

    addPort "$md_id" "deadbeef" "deadbeef - Music Player" "XINIT: $md_inst/deadbeef.sh"
}
