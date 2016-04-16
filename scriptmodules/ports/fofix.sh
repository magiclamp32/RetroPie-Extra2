#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="fofix"
rp_module_desc="FoFix - Guitar Hero and Rock Band clone"
rp_module_menus="4+"
rp_module_flags="nobin !mali !x86"
 
function depends_fofix() {
    getDepends cmake xorg
}

function sources_fofix() {
    if [ ! -a "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        gitPullOrClone "$md_build/glshim" https://github.com/ptitseb/glshim.git
    fi
}
 
function build_fofix() {
    cd "$md_build/glshim"
    cmake . -DBCMHOST=1
    make GL
}

function install_fofix() {
    aptInstall fofix
    if [ ! -a "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
       mkdir -p /opt/retropie/supplementary/glshim/
       cp "$md_build/glshim/lib/libGL.so.1" /opt/retropie/supplementary/glshim/
    fi
}
 
function configure_fofix() {
    mkdir "ports"
    moveConfigDir "$home/.fofix" "$md_conf_root/$md_id"
    addPort "$md_id" "fofix" "FoFix - Guitar Hero and Rock Band clone" "LD_LIBRARY_PATH=/opt/retropie/supplementary/glshim LIBGL_FB=1 xinit fofix"
}
