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

rp_module_id="galius"
rp_module_desc="galius - Maze of Galius"
rp_module_licence="GPL2 https://metadata.ftp-master.debian.org/changelogs//main/m/mazeofgalious/mazeofgalious_0.62.dfsg2-4_copyright"
rp_module_help="F12 to exit, CTRL-ENTER for full screen, will need to drop the resolution in runcommand to lowest for fullscreen"
rp_module_section="exp"
rp_module_flags="!mali"

function install_bin_galius() {
    aptInstall mazeofgalious xorg
}

function configure_galius() {
    addPort "$md_id" "galius" "maze of galius" "XINIT: /usr/games/mog"
}