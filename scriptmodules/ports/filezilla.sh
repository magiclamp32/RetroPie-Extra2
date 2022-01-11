#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="filezilla"
rp_module_desc="A cross platform FTP application"
rp_module_licence="https://filezilla-project.org"
rp_module_section="exp"
rp_module_flags="!mali !x86"

function depends_filezilla() {
    getDepends xorg matchbox
}

function install_bin_filezilla() {
    aptInstall filezilla
}

function configure_filezilla() {
    mkRomDir "ports"
    mkdir -p "$md_inst"
    moveConfigDir "$home/.config" "$md_conf_root/$md_id"
    cat >"$md_inst/filezilla.sh" << _EOF_
#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager -use_titlebar no &
/usr/bin/filezilla
_EOF_
    chmod +x "$md_inst/filezilla.sh"
    
     addPort "$md_id" "filezilla" "FileZilla cross platform FTP application" "xinit $md_inst/filezilla.sh"
}
