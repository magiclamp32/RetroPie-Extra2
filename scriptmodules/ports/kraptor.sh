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
