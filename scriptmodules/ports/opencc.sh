#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="opencc"
rp_module_desc="Open RA - Real Time Strategy game engine supporting early Westwood classics"
rp_module_licence="GPL3 https://github.com/OpenRA/OpenRA/blob/bleed/COPYING"
rp_module_help="Please put your Game ISO in the correct game folders and use the launcher to pull the correct files"
rp_module_section="exp"
rp_module_flags="!mali"

function depends_opencc() {
    getDepends libfreetype6 libopenal1 liblua5.1-0 libsdl2-2.0-0 xdg-utils zenity wget dbus-x11 apt-transport-https dirmngr gnupg ca-certificates
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    apt update
    aptInstall mono-devel
}

function sources_opencc() {
    
       mkdir -p openra

	wget https://github.com/OpenRA/OpenRA/releases/download/release-20210321/OpenRA-release-20210321-source.tar.bz2
	tar xvjf OpenRA-release-20210321-source.tar.bz2 -C /home/pi/RetroPie-Setup/tmp/build/opencc/openra 	
}

function build_opencc() {
        curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version 5.0.203
	echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
	echo 'export PATH=$PATH:$HOME/.dotnet' >> ~/.bashrc
	source ~/.bashrc
	
		cd openra

	make 
    md_ret_require="$md_build/openra"
}

function install_opencc() {
    md_ret_files=(
	'openra'
 )
}

function configure_opencc() {
    addPort "$md_id" "openra" "Open Red Alert" "XINIT: /opt/retropie/ports/opencc/openra/ORA.sh"
	
cat >"$md_inst/openra/ORA.sh" << _EOF_

#!/bin/bash
cd "$md_inst/openra"
./launch-game.sh Game.Mod=ra -- :0 vt\$XDG_VTNR

_EOF_

 chmod +x "$md_inst/openra/ORA.sh"

    mkRomDir "ports/openra"

addPort "$md_id" "opentd" "Open Tiberian Dawn" "XINIT: /opt/retropie/ports/opencc/openra/OTD.sh"
	
cat >"$md_inst/openra/OTD.sh" << _EOF_

#!/bin/bash
cd "$md_inst/openra"
./launch-game.sh Game.Mod=cnc -- :0 vt\$XDG_VTNR

_EOF_

 chmod +x "$md_inst/openra/OTD.sh"

    mkRomDir "ports/opentd"

addPort "$md_id" "opentd" "Open Tiberian Dawn" "XINIT: /opt/retropie/ports/opencc/openra/OD2K.sh"
	
cat >"$md_inst/openra/OD2K.sh" << _EOF_

#!/bin/bash
cd "$md_inst/openra"
./launch-game.sh Game.Mod=d2k -- :0 vt\$XDG_VTNR

_EOF_

 chmod +x "$md_inst/openra/OD2K.sh"

    mkRomDir "ports/opend2k"



}
