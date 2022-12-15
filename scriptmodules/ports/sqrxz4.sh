#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="sqrxz4"
rp_module_desc="Sqrxz 4 - Cold Cash by Retroguru"
rp_module_help="The fourth part of the quadrology Jump'n Think series Sqrxz brings you onto an cold icy island. Shiny marbles, evil penguins and ghosts, underwater creatures and many more to expect."
rp_module_licence="Retroguru http://www.retroguru.com/legal/"
rp_module_section="opt"
rp_module_flags="!x86 !mali"

function depends_sqrxz4() {
    getDepends libsdl2-2.0-0 libsdl2-mixer-2.0-0 libraspberrypi-dev
}

function install_bin_sqrxz4() {
    downloadAndExtract "http://www.retroguru.com/sqrxz4/sqrxz4-v.latest-raspberrypi.zip" "$md_inst"
    patchVendorGraphics "$md_inst/sqrxz4_rpi"
}

function configure_sqrxz4() {
    moveConfigDir "$home/.config/sqrxz4" "$md_conf_root/sqrxz4"

    addPort "$md_id" "sqrxz4" "Sqrxz 4 - Cold Cash by Retroguru" "pushd $md_inst; $md_inst/sqrxz4_rpi; popd"

    chmod +x "$md_inst/sqrxz4_rpi"
    chmod a+w "$md_inst"
}
