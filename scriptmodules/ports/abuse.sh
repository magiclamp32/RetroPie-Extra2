#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="abuse"
rp_module_desc="Abuse"
rp_module_licence="GPL https://raw.githubusercontent.com/Xenoveritas/abuse/master/COPYING"
rp_module_section="exp"
rp_module_flags="!mali"

# abuse-lib & abuse-sfx will pull in the older abuse package which only works under X
function depends_abuse() {
    getDepends cmake libsdl1.2-dev libsdl-mixer1.2-dev
}

function sources_abuse() {
	wget http://abuse.zoy.org/raw-attachment/wiki/download/abuse-0.8.tar.gz
	tar -xf abuse-0.8.tar.gz
}

function build_abuse() {
	cd abuse-0.8
	./configure --enable-debug   
	make
    md_ret_require=()
}

function install_abuse() {
   	cd abuse-0.8
	make install
	md_ret_files=(
    )
}

function configure_abuse() {
    addPort "$md_id" "abuse" "Abuse" "XINIT: /usr/local/bin/abuse -fullscreen"
}
