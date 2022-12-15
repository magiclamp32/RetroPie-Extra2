#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="duckstation"
rp_module_desc="Duckstation"
rp_module_help="ROM Extensions: .bin .cue .img .iso\n\nCopy your PSX roms to $romdir/psx\n\nCopy the required BIOS file SCPH1001.BIN to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/stenzek/duckstation/master/LICENSE"
rp_module_repo="file https://github.com/Exarkuniv/Rpi-pikiss-binary/raw/Master/duckstation-rpi-buster.tar.gz"
rp_module_section="exp"
rp_module_flags="!armv6 rpi4"

function depends_duckstation() {
    getDepends libsdl2-dev libxrandr-dev pkg-config qtbase5-dev qtbase5-private-dev qtbase5-dev-tools qttools5-dev libevdev-dev libwayland-dev libwayland-egl-dev extra-cmake-modules libcurl4-gnutls-dev libgbm-dev libdrm-dev xorg matchbox-window-manager
}

function sources_duckstation() {
    downloadAndExtract "$md_repo_url" "$md_build" "--strip-components=1"
}

function install_duckstation() {
    md_ret_files=('duckstation'
    )
}

function configure_duckstation() {
    mkRomDir "psx"
    mkUserDir "$md_conf_root/psx"
    mkdir -p "$md_inst/bios"

    # symlink the bios so it can be installed with the other bios files
    ln -sf "$biosdir/SCPH1001.BIN" "/home/pi/.local/share/duckstation/bios"

    addEmulator 0 "$md_id" "psx" "XINIT: $md_inst/duckstation.sh -fullscreen %ROM%"
    addSystem "psx"

 local file="$md_inst/duckstation.sh"
    cat >"$file" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager &
pushd "$md_inst/duckstation"
./duckstation-qt "\$@"
popd
_EOF_
    chmod +x "$file"
}