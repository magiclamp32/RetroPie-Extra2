
#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="kano-terminal"
rp_module_desc="Kano terminal games."
rp_module_section="exp"
rp_module_flags="!mali"

function install_bin_kano-terminal() {
    # Add Kano repo
    echo "deb http://dev.kano.me/archive/ release main" > /etc/apt/sources.list.d/kano.list
    wget http://dev.kano.me/archive/repo.gpg.key
    /user/bin/apt-key add repo.gpg.key
    apt-get update
    #Install games
    aptInstall make-snake
    aptInstall linux-story
}

function configure_kano-terminal() {
    mkRomDir "ports"
    addPort "$md_id" "termquest" "Terminal Quest" "linux-story-gui"
    addPort "$md_id" "makesnake" "Make Snake" "make-snake"
}

