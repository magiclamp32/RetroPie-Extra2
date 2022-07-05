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

rp_module_id="sorr"
rp_module_desc="BennuGD interpreter for Streets of Rage Remake"
rp_module_help="Please copy your SorR.dat file along with the mod and palettes folders into $romdir/ports/$md_id"
rp_module_section="exp"
rp_module_flags="!x86 !x11 !mali"

function depends_sorr() {
    getDepends libsdl-mixer1.2 libpng12-0 xorg
}

function install_bin_sorr() {
    download "https://github.com/Exarkuniv/bennugd-Rpi/raw/master/bgdi-333" "$md_inst"
    chmod +x "$md_inst/bgdi-333"
}

function configure_sorr() {
    local script="$md_inst/$md_id.sh"
    local config="$romdir/ports/$md_id/mod/system.txt"

    addPort "bgdi-333" "sorr" "Streets of Rage Remake" "XINIT:$script %ROM%" "./SorR.dat"
    [[ -f "$romdir/ports/$md_id/SorMaker.dat" || "$md_mode" == "remove" ]] && addPort "bgdi-333" "sorr" "SorMaker" "XINIT:$script %ROM%" "./SorMaker.dat"
    [[ "$md_mode" == "remove" ]] && return

    #create buffer script for launch
    cat > "$script" << _EOF_
#!/bin/bash
pushd "$romdir/ports/$md_id"
"$md_inst/bgdi-333" \$*
popd
_EOF_

    chmod +x "$script"
    mkRomDir "ports/$md_id"
    if [[ -f "$config" ]]; then
        # set custom "system" for 5.1 (allows proper "exit" from game menu)
        sed -i 's/system = PC/system = PSP/' "$config"
        # set custom "full screen wide" mode for 5.2 (allows "windowed" and "vsync" options)
        sed -i 's/^BORDERLESS_SYNC/AUTO/' "$config"
    fi
}
