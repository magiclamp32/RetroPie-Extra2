#!/usr/bin/env bash
 
# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
 
rp_module_id="splashscreen-extra"
rp_module_desc="Extra splashscreens for RetroPie"
rp_module_section="exp"
 
function sources_splashscreen-extra() {
    gitPullOrClone "$md_build" https://github.com/sur0x/retropiesplashscreen.git
}
 
function build_splashscreen-extra() {
    md_ret_require="$md_build/splashscreens"
}
 
function install_splashscreen-extra() {
    md_ret_files=(
        'splashscreens'
    )
}
 
function configure_splashscreen-extra() {
    cp -R "splashscreens" "$datadir"
    chown -R $user:$user "$datadir/splashscreens"
 
    printMsgs "dialog" "You can now choose a new splashscreen from the setup script."
}
