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

rp_module_id="gmloader"
rp_module_desc="GMLoader - play GameMaker Studio games for Android on non-Android operating systems"
rp_module_help="ROM Extensions: .apk .APK\n\nIncludes free games Maldita Castilla and Spelunky Classic HD. Use launch scripts as template for additional games."
rp_module_repo="git https://github.com/s1eve-mcdichae1/droidports.git patch-config-dir cc31738"
rp_module_licence="GPL3 https://raw.githubusercontent.com/JohnnyonFlame/droidports/master/LICENSE.md"
rp_module_section="exp"
rp_module_flags="!all rpi4"

function depends_gmloader() {
    getDepends libopenal-dev libfreetype6-dev zlib1g-dev libbz2-dev libpng-dev libzip-dev libsdl2-image-dev cmake
}

function sources_gmloader() {
    gitPullOrClone
}

function build_gmloader() {
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release -DPLATFORM=linux -DPORT=gmloader ..
    make
    md_ret_require="$md_build/build/gmloader"
}

function install_gmloader() {
    md_ret_files=('build/gmloader')
}

function configure_gmloader() {
    local apkdir="$romdir/ports/droidports"
    local maldita_url="https://locomalito.com/juegos/Maldita_Castilla_ouya.apk"
    local spelunky_url="https://github.com/yancharkin/SpelunkyClassicHD/releases/download/1.1.7/spelunky_classic_hd-android.apk"
    local maldita_file="$apkdir/$(basename ${maldita_url})"
    local spelunky_file="$apkdir/$(basename ${spelunky_url})"
    local am2r_file="$apkdir/am2r_155.apk"

    if [[ "$md_mode" == "install" ]]; then
        mkUserDir "$apkdir"
        [[ ! -f "$maldita_file" ]] && download "$maldita_url" "$apkdir"
        [[ ! -f "$spelunky_file" ]] && download "$spelunky_url" "$apkdir"
    fi

    addPort "$md_id" "droidports" "Maldita Castilla" "$md_inst/gmloader %ROM%" "$maldita_file"
    addPort "$md_id" "droidports" "Spelunky Classic HD" "$md_inst/gmloader %ROM%" "$spelunky_file"

    if [[ -f "$am2r_file" || "$md_mode" == "remove" ]]; then
        addPort "$md_id" "droidports" "AM2R - Another Metroid 2 Remake" "$md_inst/gmloader %ROM%" "$am2r_file"
    fi

    moveConfigDir "$home/.config/gmloader" "$md_conf_root/droidports"
}
