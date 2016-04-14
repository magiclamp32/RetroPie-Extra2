#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="attract-mode"
rp_module_desc="Attract Mode - Emulator Frontend"
rp_module_menus="4+"

function depends_attract-mode() {
    local depends=(
        cmake libx11-dev libx11-xcb-dev libflac-dev libogg-dev libvorbis-dev libopenal-dev libjpeg62-turbo-dev 
        libfreetype6-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev 
        libxcb-icccm4-dev libudev-dev libavutil-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev 
        libavresample-dev libfontconfig1-dev libxrandr2 libxrandr-dev libgles2-mesa-dev xinit
        )
    getDepends "${depends[@]}"
}

function sources_attract-mode() {
    gitPullOrClone "$md_build/sfml-pi" "https://github.com/mickelson/SFML" "rpi"
    gitPullOrClone "$md_build/attract" "https://github.com/mickelson/attract"
#    sed -i 's/CFLAGS += -I\/opt\/vc\/include -L\/opt\/vc\/lib/CFLAGS += -I\/opt\/vc\/include -I\/opt\/retropie\/supplementary\/attract-mode\/include -L\/opt\/vc\/lib\/ -L\/opt\/retropie\/supplementary\/attract-mode\/lib/' "$md_build/attract/Makefile"
}

function build_attract-mode() {
    cd "$md_build/sfml-pi"
    mkdir build
    cd build
    cmake -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DFREETYPE_INCLUDE_DIR_freetype2=/usr/include -DFREETYPE_INCLUDE_DIR_ft2build=/usr/include/freetype2 -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so -DSFML_BCMHOST=1 -DSFML_OPENGL_ES=1 .. 
    make install
    ldconfig
    cd ../../attract
    make USE_GLES=1
    md_ret_require="$md_build/attract/attract"
}

function install_attract-mode() {
    cd "$md_build/attract"
    cp attract "$md_inst"
    mkdir "$md_inst/share"
    cp -R config/* "$md_inst/share/"
}

function configure_attract-mode() {
    moveConfigDir "$home/.attract" "$md_conf_root/all/attract-mode"
    cat > /usr/bin/attract-mode << _EOF_
#!/bin/bash

if [[ \$(id -u) -eq 0 ]]; then
    echo "attract-mode should not be run as root. If you used 'sudo attract-mode', please run without sudo."
    exit 1
fi


clear
pushd "$md_inst" >/dev/null
xinit /opt/retropie/supplementary/attract-mode/attract
popd >/dev/null

_EOF_

    chmod +x /usr/bin/attract-mode
}


