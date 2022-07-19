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

rp_module_id="ulmos-adventure"
rp_module_desc="Ulmo's Adventure - Simple Adventure Game"
rp_module_repo="git https://github.com/rm-hull/ulmos-adventure.git"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_ulmos-adventure() {
    getDepends python-pygame python-cwiid
}

function sources_ulmos-adventure() {
    gitPullOrClone
}

function install_ulmos-adventure() {
    cp -Rv "$md_build/game/src" "$md_inst"
}

function configure_ulmos-adventure() {
    chown -R $user:$user "$md_inst"
    addPort "$md_id" "ulmos-adventure" "Ulmo's Adventure - Simple Adventure Game" "pushd $md_inst/src/; python play.py; popd"
}
