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
    moveConfigDir "$home/.config/$md_id" "$md_conf_root/ports/$md_id"
    addEmulator 1 "$md_id" "videos" "omxplayer %ROM%"
    addSystem "videos" "Videos" ".mp4 .MP4 .mov .MOV .avi .AVI .mkv .MKV"
}