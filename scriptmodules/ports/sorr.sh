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
    addPort "bgdi-333" "sorr" "Streets of Rage Remake" "XINIT:pushd $romdir/ports/sorr; $md_inst/bgdi-333 %ROM%; popd" "./SorR.dat"
    [[ -f "$romdir/ports/sorr/SorMaker.dat" ]] && addPort "bgdi-333" "sorr" "SorMaker" "XINIT:pushd $romdir/ports/sorr; $md_inst/bgdi-333 %ROM%; popd" "./SorMaker.dat"
    [[ "$md_mode" == "remove" ]] && return

    mkRomDir "ports/sorr"
    local config="$romdir/ports/sorr/mod/system.txt"
    if [[ -f "$config" ]]; then
        # set custom "system" for 5.1 (allows proper "exit" from game menu)
        sed -i 's/system = PC/system = PSP/' "$config"
        # set custom "full screen wide" mode for 5.2 (allows "windowed" and "vsync" options)
        sed -i 's/^BORDERLESS_SYNC/AUTO/' "$config"
    fi
}
