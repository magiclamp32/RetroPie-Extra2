#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="reminiscence"
rp_module_desc="REminiscence - Flashback Engine"
rp_module_menus="4+"
rp_module_flags="!mali !x86"

function depends_reminiscence() {
    getDepends libsdl1.2-dev
}

function sources_reminiscence() {
    wget -O- -q http://cyxdown.free.fr/reminiscence/REminiscence-0.2.1.tar.bz2 | tar -xvj --strip-components=1
}

function build_reminiscence() {
    make
}

function install_reminiscence() {
    md_ret_files=('rs')
}

function configure_reminiscence() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"

    addPort "$md_id" "reminiscence" "REminiscence" "$md_inst/rs --datapath=$romdir/ports/$md_id --savepath=$configdir/$md_id"
    __INFMSGS+=("Please copy your Flashback data files to $romdir/ports/$md_id before running REminiscence.")
}
