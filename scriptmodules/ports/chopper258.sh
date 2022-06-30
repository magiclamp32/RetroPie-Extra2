#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="chopper258"
rp_module_desc="Chopper Commando Revisited - a modern port of Chopper Commando (DOS, 1990), written by Mark Currie and ported by loadzero"
rp_module_help="A keyboard is required."
rp_module_repo="git https://github.com/loadzero/chopper258 master"
rp_module_licence="freeware https://raw.githubusercontent.com/loadzero/chopper258/master/CREDITS.txt"
rp_module_section="exp"
rp_module_flags="sdl2"

function depends_chopper258() {
    getDepends libsdl2-dev
}

function sources_chopper258() {
    gitPullOrClone
}

function build_chopper258() {
    make
    md_ret_require="$md_build/bin/chopper258"
}

function install_chopper258() {
    md_ret_files='bin/chopper258'
}

function configure_chopper258() {
    local confdir="$md_conf_root/$md_id"

    addPort "$md_id" "chopper258" "Chopper Commando" "pushd $confdir; $md_inst/chopper258; popd"
    mkUserDir "$confdir"
}
