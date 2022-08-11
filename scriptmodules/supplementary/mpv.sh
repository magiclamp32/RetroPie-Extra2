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

rp_module_id="mpv"
rp_module_desc="mpv - Video Player"
rp_module_help="This will set up TV Shows and Movies as systems on your wheel. You can throw your tv shows into $romdir/tvshows and your movies into $romdir/movies or even mount your network drives to play remotely.\n\nROM Extensions: .avi .m4v .mkv .mov .mp4 .mpg .wmv"
rp_module_licence="GPL2 https://raw.githubusercontent.com/mpv-player/mpv/master/Copyright"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function install_bin_mpv() {
    aptInstall mpv
}

function configure_mpv() {
    mkRomDir "movies"
    mkRomDir "tvshows"
    addEmulator 1 "$md_id" "movies" "/usr/bin/mpv %ROM%" 
    addEmulator 1 "$md_id" "tvshows" "/usr/bin/mpv %ROM%" 
    addSystem "movies" "Movies" ".avi .m4v .mkv .mov .mp4 .mpg .wmv .AVI .M4V .MKV .MOV .MP4 .MPG .WMV"
    addSystem "tvshows" "TVshows" ".avi .m4v .mkv .mov .mp4 .mpg .wmv .AVI .M4V .MKV .MOV .MP4 .MPG .WMV"
}