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

rp_module_id="gearboy"
rp_module_desc="Gearboy - Gameboy & Gameboy Color Emulator"
rp_module_licence="GPL3 https://raw.githubusercontent.com/drhelius/Gearboy/master/LICENSE"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_gearboy() {
    getDepends build-essential libfreeimage-dev libopenal-dev libpango1.0-dev libsndfile1-dev libudev-dev libasound2-dev libjpeg-dev libtiff5-dev libwebp-dev automake libconfig++-dev libsdl2-dev libglew-dev
    #if [[ "$__raspbian_ver" -lt "8" ]]; then
    #    getDepends libjpeg8-dev
    #else
    #    getDepends libjpeg-dev
    #fi
}

function sources_gearboy() {
    gitPullOrClone "$md_build" https://github.com/DrHelius/GearBoy.git
}

function build_gearboy() {
    if isPlatform "rpi1"; then
        cd "$md_build/platforms/raspberrypi"
    elif isPlatform "rpi2"; then
        cd "$md_build/platforms/raspberrypi2"
    elif isPlatform "rpi3"; then
        cd "$md_build/platforms/raspberrypi3"
    elif isPlatform "rpi4"; then
        cd "$md_build/platforms/raspberrypi4"
    fi

    make clean
    make
    strip "gearboy"
    if isPlatform "rpi1"; then
	echo "Installing for Raspberry Pi..."
        md_ret_require="$md_build/platforms/raspberrypi/gearboy"
    elif isPlatform "rpi2"; then
	echo "Installing for Raspberry Pi 2..."
        md_ret_require="$md_build/platforms/raspberrypi2/gearboy"
    elif isPlatform "rpi3"; then
    	echo "Installing for Raspberry Pi 3..."
        md_ret_require="$md_build/platforms/raspberrypi3/gearboy"
    elif isPlatform "rpi4"; then
        echo "Installing for Raspberry Pi 4..."
        md_ret_require="$md_build/platforms/raspberrypi4/gearboy"
    fi
}

function install_gearboy() {
    if isPlatform "rpi1"; then
        cp "$md_build/platforms/raspberrypi/gearboy" "$md_inst/gearboy"
    elif isPlatform "rpi2"; then
        cp "$md_build/platforms/raspberrypi2/gearboy" "$md_inst/gearboy"
    elif isPlatform "rpi3"; then
        cp "$md_build/platforms/raspberrypi3/gearboy" "$md_inst/gearboy"
    elif isPlatform "rpi4"; then
        cp "$md_build/platforms/raspberrypi4/gearboy" "$md_inst/gearboy"
    fi
}

function configure_gearboy() {
    mkRomDir "gameboy"
    moveConfigFile "$home/gearboy.cfg" "$md_conf_root/gearboy/gearboy.cfg"
    addSystem 0 "$md_id" "gearboy" "$md_inst/gearboy %ROM%"
}
