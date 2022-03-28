#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="sorr"
rp_module_desc="BennuGD interpreter for Streets of Rage Remake"
rp_module_help="Please copy your SorR.dat file along with the mod and palettes folders into $romdir/ports/sorr"
rp_module_section="exp"
rp_module_flags="!x86 !x11 !mali"

function depends_sorr() {
    getDepends libsdl-mixer1.2 libpng12-0 xorg
}

function install_bin_sorr() {
    download "https://github.com/Exarkuniv/bennugd-Rpi/raw/master/bgdi-333" "$md_inst"
    chmod 755 "$md_inst/bgdi-333"
}

function configure_sorr() {
    addPort "bgdi-333" "sorr" "Streets of Rage Remake" "XINIT:pushd $romdir/ports/sorr; $md_inst/bgdi-333 ./SorR.dat; popd"
    [[ "$md_mode" == "remove" ]] && return

    mkRomDir "ports/sorr"
    # custom system.txt to set full screen mode: AUTO
    mkRomDir "ports/sorr/mod"
    cat >"$romdir/ports/sorr/mod/system.txt" << _EOF_
// GAME PORTS: PC, WIZ, XBOX, PSP, WII, ANDROID, HANDHELD
PC

// LOADING TYPE: PRELOAD, REALTIME
PRELOAD

// FULL SCREEN WIDE: AUTO, DESKTOP, BORDERLESS, BORDERLESS_SYNC
AUTO

// XBOX CONTROL LAYOUT: (Y,A,B = JOY NUMBER)
3
0
1
_EOF_
}
