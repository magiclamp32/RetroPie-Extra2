#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="supaplex"
rp_module_desc="Reverse engineering Supaplex"
rp_module_help="play the game"
rp_module_licence="GNU https://www.gnu.org/licenses/gpl-3.0"
rp_module_repo="file https://github.com/Exarkuniv/Rpi-pikiss-binary/raw/Master/open-supaplex-rpi.tar.gz"
rp_module_section="exp"
rp_module_flags="!armv6 rpi4"

function depends_supaplex() {
    getDepends libsdl2-mixer-2.0-0 
}

function sources_supaplex() {
    downloadAndExtract "$md_repo_url" "$md_build"
}

function install_supaplex() {
    md_ret_files=('open-supaplex')
}

function configure_supaplex() {
    local script="$md_inst/$md_id.sh"

    cat > "$script" << _EOF_
#!/bin/bash
cd $md_inst/open-supaplex && ./opensupaplex.sh
_EOF_

    addPort "$md_id" "supaplex" "supaplex" "$script"
    moveConfigDir "$home/.config/supaplex" "$md_conf_root/supaplex"
    chmod +x "$md_inst"
    chmod +x "$script"
}