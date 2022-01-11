#!/usr/bin/env bash
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
rp_module_id="omxplayer"
rp_module_desc="omxplayer - Video Player"
rp_module_help="Put your videos into $"
rp_module_licence="GPL2 https://www.gnu.org/licenses/gpl-2.0.txt"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function install_bin_omxplayer() {
    aptInstall omxplayer
}
function configure_omxplayer() {
    mkRomDir "videos"
    addEmulator 0 "$md_id" "videos" "omxplayer %ROM%"
    addSystem "videos" "Videos" ".mp4 .MP4 .mov .MOV .avi .AVI .mkv .MKV"
}
