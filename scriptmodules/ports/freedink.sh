#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://github.com/Exarkuniv/RetroPie-Extra/blob/master/LICENSE
#

rp_module_id="freedink"
rp_module_desc="FreeDink - Dink Smallwood Engine"
rp_module_licence="GPL3 http://git.savannah.gnu.org/cgit/freedink.git/plain/COPYING"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_freedink() {
    getDepends  libvorbis-dev timgm6mb-soundfont
}

function install_bin_freedink() {
    aptInstall freedink
}

function remove_freedink() {
    aptRemove freedink
}

function configure_freedink() {
    moveConfigDir "$home/.dink" "$md_conf_root/$md_id"
    addPort "$md_id" "freedink" "FreeDink - Dink Smallwood Engine" "freedink -S"
}
