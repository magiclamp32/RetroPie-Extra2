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

rp_module_id="lr-ppsspp-latest"
rp_module_desc="PlayStation Portable emu - PPSSPP port for libretro - latest master version"
rp_module_help="ROM Extensions: .iso .pbp .cso\n\nCopy your PlayStation Portable roms to $romdir/psp"
rp_module_licence="GPL2 https://raw.githubusercontent.com/RetroPie/ppsspp/master/LICENSE.TXT"
rp_module_repo="git https://github.com/hrydgard/ppsspp.git master"
rp_module_section="exp"
rp_module_flags="!videocore"

function depends_lr-ppsspp-latest() {
    depends_ppsspp-latest
}

function sources_lr-ppsspp-latest() {
    sources_ppsspp-latest
}

function build_lr-ppsspp-latest() {
    build_ppsspp-latest
}

function install_lr-ppsspp-latest() {
    md_ret_files=(
        'ppsspp/lib/ppsspp_libretro.so'
        'ppsspp/assets'
    )
}

function configure_lr-ppsspp-latest() {
    mkRomDir "psp"
    ensureSystemretroconfig "psp"

    if [[ "$md_mode" == "install" ]]; then
        mkUserDir "$biosdir/PPSSPP"
        cp -Rv "$md_inst/assets/"* "$biosdir/PPSSPP/"
        chown -R $user:$user "$biosdir/PPSSPP"

        # the core needs a save file directory, use the same folder as standalone 'ppsspp'
        iniConfig " = " "" "$configdir/psp/retroarch.cfg"
        iniSet "savefile_directory" "$home/.config/ppsspp"
        moveConfigDir "$home/.config/ppsspp" "$md_conf_root/psp"
    fi

    addEmulator 1 "$md_id" "psp" "$md_inst/ppsspp_libretro.so"
    addSystem "psp"

    # if we are removing the last remaining psp emu - remove the symlink
    if [[ "$md_mode" == "remove" ]]; then
        if [[ -h "$home/.config/ppsspp" && ! -f "$md_conf_root/psp/emulators.cfg" ]]; then
            rm -f "$home/.config/ppsspp"
        fi
    fi
}
