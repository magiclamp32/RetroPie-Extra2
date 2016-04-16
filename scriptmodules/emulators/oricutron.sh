#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="oricutron"
rp_module_desc="Oricutron Oric 1/Oric Atmos emulator"
rp_module_menus="4+"
rp_module_flags="!mali"

function depends_oricutron() {
    getDepends cmake libsdl1.2-dev
}

function sources_oricutron() {
    gitPullOrClone "$md_build" https://github.com/HerbFargus/oricutron.git
}

function build_oricutron() {
    make clean
    make
}

function install_oricutron() {
    md_ret_files=(
        'oricutron'
        'oricutron.cfg'
        'roms'
        'disks'
        'images'
    )
}

function configure_oricutron() {
    mkRomDir "oric"

    #copy demo disks
    mv -v $md_inst/disks/* "$romdir/oric/"
    rm -R $md_inst/disks/

    addSystem 1 "$md_id-atmos" "oric" "pushd; $md_inst/oricutron; --machine "atmos" %ROM% --fullscreen; popd" "Oric 1" ".dsk .tap"
    addSystem 0 "$md_id-oric1" "oric" "$md_inst/oricutron --machine "oric1" %ROM% --fullscreen" "Oric 1" ".dsk .tap"
    addSystem 0 "$md_id-o16k" "oric" "$md_inst/oricutron --machine "o16k" %ROM% --fullscreen" "Oric 1" ".dsk .tap"
    addSystem 0 "$md_id-telestrat" "oric" "$md_inst/oricutron --machine "telestrat" %ROM% --fullscreen" "Oric 1" ".dsk .tap"
    addSystem 0 "$md_id-pravetz" "oric" "$md_inst/oricutron --machine "pravetz" %ROM% --fullscreen" "Oric 1" ".dsk .tap"

    chown -R $user:$user "$romdir/oric"
}
