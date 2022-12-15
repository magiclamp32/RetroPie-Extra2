#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="temptations"
rp_module_desc="Temptations - enhanced version of the MXS game"
rp_module_help="F11 - Switches between Window and Full Screen.
 · G - Switches graphics between MSX Original and Nene Franz's new one.
 · L - Switches between Spanish and English language.
 · M - Switches Music off or on.
 · P - Pause."
rp_module_licence="GNU https://www.gnu.org/licenses/gpl-3.0"
rp_module_repo="file https://github.com/Exarkuniv/Rpi-pikiss-binary/raw/Master/temptations-rpi.tar.gz"
rp_module_section="exp"
rp_module_flags="!armv6 rpi4"

function depends_temptations() {
    getDepends libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 libsdl2-dev libsdl2-mixer-dev libsdl2-image-dev 
}

function sources_temptations() {
    downloadAndExtract "$md_repo_url" "$md_build"
}

function install_temptations() {
    md_ret_files=('temptations')
}

function configure_temptations() {
     local script="$md_inst/$md_id.sh"
    cat > "$script" << _EOF_
#!/bin/bash
cd $md_inst/temptations && ./temptations
_EOF_

    addPort "$md_id" "temptations" "Temptations" "$script"
    moveConfigDir "$home/.config/temptations" "$md_conf_root/temptations"
    chmod +x "$md_inst"
    chmod +x "$script"
}