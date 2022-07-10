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

rp_module_id="fofix"
rp_module_desc="FoFix - Guitar Hero and Rock Band clone"
rp_module_licence="GPL2 https://raw.githubusercontent.com/fofix/fofix/master/COPYING"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_fofix() {
    getDepends cmake xorg
}

function sources_fofix() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        gitPullOrClone "$md_build/glshim" https://github.com/ptitseb/glshim.git
    fi
}

function build_fofix() {
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
        cd "$md_build/glshim"
        cmake . -DBCMHOST=1
        make GL
    fi
}

function install_bin_fofix() {
    aptInstall fofix
    if [ ! -f "/opt/retropie/supplementary/glshim/libGL.so.1" ]; then
       mkdir -p /opt/retropie/supplementary/glshim/
       cp "$md_build/glshim/lib/libGL.so.1" /opt/retropie/supplementary/glshim/
    fi
}

function configure_fofix() {
    mkdir "ports"
    moveConfigDir "$home/.fofix" "$md_conf_root/$md_id"
    addPort "$md_id" "fofix" "FoFix - Guitar Hero and Rock Band clone" "LD_LIBRARY_PATH=/opt/retropie/supplementary/glshim LIBGL_FB=1 xinit fofix"
}
