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
rp_module_licence="GPL3 https://raw.githubusercontent.com/mickelson/attract/master/License.txt"
rp_module_section="exp"

function depends_attract-mode() {
    local depends=(
        cmake libflac-dev libogg-dev libvorbis-dev libopenal-dev libjpeg62-turbo-dev 
        libudev-dev libavutil-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev 
        libavresample-dev libfontconfig1-dev
        )
    getDepends "${depends[@]}"
}

function sources_attract-mode() {
    gitPullOrClone "$md_build/sfml-pi" "https://github.com/mickelson/sfml-pi"
    gitPullOrClone "$md_build/attract" "https://github.com/mickelson/attract"
#    sed -i 's/CFLAGS += -I\/opt\/vc\/include -L\/opt\/vc\/lib/CFLAGS += -I\/opt\/vc\/include -I\/opt\/retropie\/supplementary\/attract-mode\/include -L\/opt\/vc\/lib\/ -L\/opt\/retropie\/supplementary\/attract-mode\/lib/' "$md_build/attract/Makefile"
}

function build_attract-mode() {
    cd "$md_build/sfml-pi"
    mkdir build
    cd build
    cmake .. -DSFML_RPI=1 -DEGL_INCLUDE_DIR=/opt/vc/include -DEGL_LIBRARY=/opt/vc/lib/libEGL.so -DGLES_INCLUDE_DIR=/opt/vc/include -DGLES_LIBRARY=/opt/vc/lib/libGLESv1_CM.so 
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
/opt/retropie/supplementary/attract-mode/attract
popd >/dev/null

_EOF_

    chmod +x /usr/bin/attract-mode
}


