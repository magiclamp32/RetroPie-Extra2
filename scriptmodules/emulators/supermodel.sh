#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="supermodel"
rp_module_desc="Sega Model 3 Arcade emulator"
rp_module_help="ROM Extensions: .zip\n\nCopy your Model 3 roms to $romdir/model3"
rp_module_licence="GPL3 https://sourceforge.net/p/model3emu/code/HEAD/tree/trunk/Docs/LICENSE.txt"
rp_module_section="exp"
rp_module_flags="sdl2"

function depends_supermodel() {
    getDepends subversion libglew-dev libsdl2-dev libsdl2-net-dev libzip-dev zlib1g-dev 
}

function sources_supermodel() {
    local revision="$1"
    [[ -z "$revision" ]] && revision="863"

    svn checkout https://svn.code.sf.net/p/model3emu/code/trunk "$md_build" -r "$revision"
}

function build_supermodel() {
    #Controller configuration
    sed -i 's|InputStart1 = "KEY_1,JOY1_BUTTON9"|InputStart1 = "KEY_1,JOY1_BUTTON10"|g' ./Config/Supermodel.ini
    sed -i 's|InputStart2 = "KEY_2,JOY2_BUTTON9"|InputStart2 = "KEY_2,JOY2_BUTTON10"|g' ./Config/Supermodel.ini
    sed -i 's|InputCoin1 = "KEY_3,JOY1_BUTTON10"|InputCoin1 = "KEY_3,JOY1_BUTTON9"|g' ./Config/Supermodel.ini
    sed -i 's|InputCoin2 = "KEY_4,JOY2_BUTTON10"|InputCoin2 = "KEY_4,JOY2_BUTTON9"|g' ./Config/Supermodel.ini
    sed -i 's|InputAccelerator = "KEY_UP,JOY1_UP"|InputAccelerator = "KEY_UP,JOY1_RYAXIS_NEG"|g' ./Config/Supermodel.ini
    sed -i 's|InputBrake = "KEY_DOWN,JOY1_DOWN"|InputBrake = "KEY_DOWN,JOY1_RYAXIS_POS"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShiftUp = "KEY_Y"|InputGearShiftUp = "KEY_Y,JOY1_BUTTON6,JOY1_RZAXIS_POS"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShiftDown = "KEY_H"|InputGearShiftDown = "KEY_H,JOY1_BUTTON5,JOY1_ZAXIS_POS"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShift1 = "KEY_Q,JOY1_BUTTON5"|InputGearShift1 = "KEY_Q"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShift2 = "KEY_W,JOY1_BUTTON6"|InputGearShift2 = "KEY_W"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShift3 = "KEY_E,JOY1_BUTTON7"|InputGearShift3 = "KEY_E"|g' ./Config/Supermodel.ini
    sed -i 's|InputGearShift4 = "KEY_R,JOY1_BUTTON8"|InputGearShift4 = "KEY_R"|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogJoyX = "JOY_XAXIS,MOUSE_XAXIS"   ; analog, full X axis|InputAnalogJoyX = "JOY_XAXIS_INV,MOUSE_XAXIS_INV"   ; analog, full X axis|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogJoyY = "JOY_YAXIS,MOUSE_YAXIS"   ; analog, full Y axis|InputAnalogJoyY = "JOY_YAXIS_INV,MOUSE_YAXIS_INV"   ; analog, full Y axis|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogGunX2 = "NONE"|InputAnalogGunX2 = "JOY2_XAXIS"|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogGunY2 = "NONE"|InputAnalogGunY2 = "JOY2_YAXIS"|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogTriggerLeft2 = "NONE"|InputAnalogTriggerLeft2 = "JOY2_BUTTON1"|g' ./Config/Supermodel.ini
    sed -i 's|InputAnalogTriggerRight2 = "NONE"|InputAnalogTriggerRight2 = "JOY2_BUTTON2"|g' ./Config/Supermodel.ini
   
    ln -s Makefiles/Makefile.UNIX Makefile
    make
    cd bin
    cp -r "$scriptdir/scriptmodules/emulators/supermodel/NVRAM" "NVRAM"
    mkdir -p Config Saves
    cp ../Config/Supermodel.ini Config
    cp ../Config/Games.xml Config
    
    cd Config
    way="$md_inst/bin/Config"
    if [[ -e $way/Supermodel.ini ]]; then
	mv Supermodel.ini Supermodel.ini.rp-dist
    fi

    md_ret_require="$md_build/bin/supermodel"
}

function install_supermodel() {
    md_ret_files=(
	'bin'
        'Docs/LICENSE.txt'
        'Docs/README.txt'
    )
}

function configure_supermodel() {
    #Find out Screen Resolution
    local Xaxis
    local Yaxis
    Xaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
    Yaxis=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

    mkRomDir "model3"
    
    moveConfigDir "$md_inst/bin/Config" "$md_conf_root/model3/Config"
    moveConfigDir "$md_inst/bin/NVRAM" "$home/.model3/NVRAM"
    moveConfigDir "$md_inst/bin/Saves" "$home/.model3/Saves"

    chown -R $user:$user "$md_conf_root/model3/Config"
    chown -R $user:$user "$home/.model3"

    addEmulator 0 "$md_id-legacy3d" "model3" "$md_inst/supermodel.sh -res=$Xaxis,$Yaxis -fullscreen -legacy3d -quad-rendering %ROM%"
    addEmulator 0 "$md_id-new3d" "model3" "$md_inst/supermodel.sh -res=$Xaxis,$Yaxis -fullscreen -quad-rendering %ROM%"
    addEmulator 0 "$md_id-nv-optimus" "model3" "optirun $md_inst/supermodel.sh -res=$Xaxis,$Yaxis -fullscreen -quad-rendering %ROM%"

    addSystem "model3"

    local file="$md_inst/supermodel.sh"
    cat >"$file" << _EOF_
#!/bin/bash
pushd "$md_inst/bin"
./$md_id "\$@"
popd
_EOF_
    chmod +x "$file"
}
