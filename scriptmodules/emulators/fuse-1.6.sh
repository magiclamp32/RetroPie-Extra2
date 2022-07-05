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

rp_module_id="fuse-1.6"
rp_module_desc="ZX Spectrum emulator Fuse"
rp_module_help="ROM Extensions: .sna .szx .z80 .tap .tzx .gz .udi .mgt .img .trd .scl .dsk .zip\n\nCopy your ZX Spectrum games to $romdir/zxspectrum"
rp_module_licence="GPL2 https://sourceforge.net/p/fuse-emulator/fuse/ci/master/tree/COPYING"
rp_module_repo="file $__archive_url/fuse-1.6.0.tar.gz"
rp_module_section="exp"
rp_module_flags="sdl1 !mali"

function depends_fuse-1.6() {
    getDepends libsdl1.2-dev libpng-dev zlib1g-dev libbz2-dev libaudiofile-dev bison flex
}

function sources_fuse-1.6() {
    downloadAndExtract "$__archive_url/fuse-1.6.0.tar.gz" "$md_build" --strip-components 1
    mkdir libspectrum
    downloadAndExtract "$__archive_url/libspectrum-1.5.0.tar.gz" "$md_build/libspectrum" --strip-components 1
    if ! isPlatform "x11"; then
        applyPatch "$md_data/01_disable_cursor.diff"
    fi
    applyPatch "$md_data/02_sdl_fix.diff"
}

function build_fuse-1.6() {
    pushd libspectrum
    ./configure --disable-shared
    make clean
    make
    popd
    ./configure --prefix="$md_inst" --without-libao --without-gpm --without-gtk --without-libxml2 --with-sdl LIBSPECTRUM_CFLAGS="-I$md_build/libspectrum" LIBSPECTRUM_LIBS="-L$md_build/libspectrum/.libs -lspectrum"
    make clean
    make
    md_ret_require="$md_build/fuse"
}

function install_fuse-1.6() {
    make install
}

function configure_fuse-1.6() {
    mkRomDir "zxspectrum"

    addEmulator 0 "$md_id-48k" "zxspectrum" "$md_inst/bin/fuse --machine 48 --full-screen %ROM%"
    addEmulator 0 "$md_id-128k" "zxspectrum" "$md_inst/bin/fuse --machine 128 --full-screen %ROM%"
    addSystem "zxspectrum"

    [[ "$md_mode" == "remove" ]] && return

    mkUserDir "$md_conf_root/zxspectrum"
    moveConfigFile "$home/.fuserc" "$md_conf_root/zxspectrum/.fuserc"

    # default to dispmanx backend
    isPlatform "dispmanx" && _backend_set_fuse "dispmanx"

    local script="$romdir/zxspectrum/+Start Fuse.sh"
    cat > "$script" << _EOF_
#!/bin/bash
$md_inst/bin/fuse --machine 128 --full-screen
_EOF_
    chown $user:$user "$script"
    chmod +x "$script"
}

function _backend_set_fuse-1.6() {
    local mode="$1"
    local force="$2"
    setBackend "$md_id" "$mode" "$force"
    setBackend "$md_id-48k" "$mode" "$force"
    setBackend "$md_id-128k" "$mode" "$force"
}
