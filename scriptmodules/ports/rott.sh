#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rott"
rp_module_desc="rott - Rise of the Triad port"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_rott() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev automake autoconf subversion
}

function sources_rott() {
    svn export svn://svn.icculus.org/rott/trunk/
}

function build_rott() {
    cd trunk
    autoreconf -fiv
    ./configure --prefix="$md_inst" --enable-datadir="$romdir/ports/$md_id/"
    make
    md_ret_require="$md_build/trunk/rott"
}

function install_rott() {
    cd trunk
    make install
}

function configure_rott() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"

    moveConfigDir "$home/.rott" "$configdir/rott"

    addPort "$md_id" "rott" "rott - Rise of the Triad port" "$md_inst/bin/rott"
    __INFMSGS+=("Please add your ROTT files to $romdir/ports/$md_id/ to play.")
}
