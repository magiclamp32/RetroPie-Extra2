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

rp_module_id="tinyfugue"
rp_module_desc="TinyFugue - Console MUD Client"
rp_module_licence="GPL2 https://raw.githubusercontent.com/kruton/tinyfugue/widechar/COPYING"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_tinyfugue() {
    	getDepends xdg-utils matchbox xorg
}

function install_bin_tinyfugue() {
        aptInstall tf
}

function configure_tinyfugue() {
    mkRomDir "ports"

    cat >"$romdir/ports/tinyfugue.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
xterm -rv /usr/games/tf
_EOF_
    chmod +x "$romdir/ports/tinyfugue.sh"

    addPort "$md_id" "tinyfugue" "TinyFugue - Console MUD Client" "xinit $romdir/ports/tinyfugue.sh"
}
