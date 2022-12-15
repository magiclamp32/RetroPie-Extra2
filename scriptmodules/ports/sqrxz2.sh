#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="sqrxz2"
rp_module_desc="Sqrxz 2 - Two seconds until death by Retroguru"
rp_module_help="Sqrxz 2 is a Jump'n'Run which requires a sharp mind and fast reflexes, high frustration is guaranteed."
rp_module_licence="Retroguru http://www.retroguru.com/legal/"
rp_module_section="opt"
rp_module_flags="!x86 !mali"

function depends_sqrxz2() {
    getDepends libsdl1.2-dev libsdl-mixer1.2 libraspberrypi-dev xorg
}

function install_bin_sqrxz2() {
    downloadAndExtract "http://www.retroguru.com/sqrxz2/sqrxz2-v.latest-raspberrypi.zip" "$md_inst"
    patchVendorGraphics "$md_inst/sqrxz2_rpi"
}

function configure_sqrxz2() {
     local script="$md_inst/$md_id.sh"
    moveConfigDir "$home/.config/sqrxz2" "$md_conf_root/sqrxz2"

    cat > "$script" << _EOF_
#!/bin/bash
pushd "$md_inst"
"$md_inst/sqrxz2_rpi" \$*
popd
_EOF_

    addPort "$md_id" "sqrxz2" "Sqrxz 2 - Two seconds until death by Retroguru" "XINIT: pushd $md_inst; $md_inst/sqrxz2_rpi; popd"

    chmod +x "$script"
    chmod +x "$md_inst/sqrxz2_rpi"
    chmod a+w "$md_inst"
}
