#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="augustus"
rp_module_desc="Augustus - Enhanced Caesar III source port"
rp_module_licence="GPL3 https://github.com/Keriew/augustus/blob/master/LICENSE.txt"
rp_module_help="Augustus requires the original assets (graphics, sounds, etc) from Caesar 3 to run. Add all data files from your Caesar 3 installation folder to $romdir/ports/caesar3. If you want the MP3 music you need to install them to the MP3 folder in the Caesar 3 folder" 
rp_module_section="exp"
rp_module_flags=""

function depends_augustus() {
    getDepends cmake libsdl2-dev libsdl2-net-dev libsdl2-mixer-dev libsdl2-image-dev libsdl-mixer1.2-dev libmpg123-0 libsdl2-mixer-dev
}

function sources_augustus() {
    gitPullOrClone "$md_build" https://github.com/Keriew/augustus.git
	
}

function build_augustus() {
    cd "$md_build"
    cmake .
    make

    md_ret_require="$md_build"
}

function install_augustus() {
    md_ret_files=(
       'augustus'
    )
}

function game_data_augustus() {
    chown -R $user:$user "$romdir/ports/caesar3"
}

function configure_augustus() {
    addPort "$md_id" "augustus" "Caesar III" "$md_inst/augustus $romdir/ports/caesar3"

    mkRomDir "ports/caesar3"
	mkRomDir "ports/caesar3/mp3"

    mkUserDir "$home/."
   # moveConfigDir "$home/.local/share/Kerirw/augustus" "$md_conf_root/augustus"

    [[ "$md_mode" == "install" ]] && game_data_augustus
}
