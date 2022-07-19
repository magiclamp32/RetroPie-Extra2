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

rp_module_id="lutris"
rp_module_desc="lutris - Game engine for linux"
rp_module_licence="GGPL https://github.com/lutris/lutris/blob/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_lutris() {
        getDepends git matchbox xorg
}

function sources_lutris() {
    apt-get install lutris
}

function configure_lutris() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config/$md_id" "$md_conf_root/$md_id"
    cat >"$md_inst/lutris.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/lutris
_EOF_

}
