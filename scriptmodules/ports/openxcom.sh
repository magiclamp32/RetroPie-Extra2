#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="openxcom"
rp_module_desc="OpenXCOM - Open Source X-COM Engine"
rp_module_licence="GPL3 https://raw.githubusercontent.com/SupSuper/OpenXcom/master/LICENSE.txt"
rp_module_help="Be sure to install your original data files to the proper folders in $md_inst/user/UFO. Because this uses X, you may find that you are unable to control the game and the game appears in a small window in the top left. Use the Runcommand option to set the resolution to CEA-4 or similarly smaller sizes. This will allow you to control the game as the window will have focus and also fill up more of the screen. If you just get a black screen or you return to EmulationStation, please run dpkg-reconfigure xserver-xorg-legacy as root and set it so Anybody can use X. See the troubleshooting section of the RetroPie-Extras readme for more info."
rp_module_section="exp"
rp_module_flags="!mali !x86"
 
function depends_openxcom() {
    getDepends cmake xorg libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev libsdl-gfx1.2-dev libyaml-cpp-dev xserver-xorg-legacy
}

function sources_openxcom() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        gitPullOrClone "$md_build/glshim" https://github.com/ptitseb/glshim.git
    fi
    gitPullOrClone "$md_build/$md_id" https://github.com/SupSuper/OpenXCOM.git
}
 
function build_openxcom() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        cd "$md_build/glshim"
        cmake . -DBCMHOST=1
        make GL
    fi
    cd "$md_build/$md_id"
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH="$md_inst" ..
    make
    md_ret_require="$md_build/$md_id/build/bin/openxcom"
}

function install_openxcom() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
       mkdir -p /opt/retropie/supplementary/glshim/
       cp "$md_build/glshim/lib/libGL.so.1" /opt/retropie/supplementary/glshim/
    fi
    cd "$md_build/$md_id/build/"
    make install
}
 
function configure_openxcom() {
    mkdir "ports"
    moveConfigDir "$home/.config/openxcom" "$md_conf_root/openxcom"
    mkdir -p "$md_inst/user/UFO"
    addPort "$md_id" "openxcom" "OpenXCOM - Open Source X-COM Engine" "LD_LIBRARY_PATH=/opt/retropie/supplementary/glshim LIBGL_FB=1 sudo xinit $md_inst/bin/openxcom"
}
