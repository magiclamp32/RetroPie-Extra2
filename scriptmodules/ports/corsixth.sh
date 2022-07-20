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

rp_module_id="corsixth"
rp_module_desc="CorsixTH - Theme Hospital Engine"
rp_module_licence="MIT https://raw.githubusercontent.com/CorsixTH/CorsixTH/master/LICENSE.txt"
rp_module_help="Mouse or mouse emulation through xboxdrv is required. You need to copy your Theme Hospital game data into $romdir/ports/$md_id/. The colors and fonts could have bad colors here making it difficult."
rp_module_repo="git https://github.com/CorsixTH/CorsixTH.git"
rp_module_section="exp"
rp_module_flags="!x86 !mali"

function depends_corsixth() {
    getDepends cmake liblua5.2-0 liblua5.2-dev libsdl2-dev libsdl2-mixer-dev timidity libfreetype6-dev lua-filesystem lua-lpeg libavcodec-dev libavformat-dev libavresample-dev libavutil-dev libavdevice-dev libswscale-dev libpostproc-dev libavfilter-dev matchbox freepats
}

function sources_corsixth() {
    gitPullOrClone
}

function build_corsixth() {
    cmake . -DWITH_LIBAV=ON -DCMAKE_INSTALL_PREFIX:PATH="$md_inst"
    cd ./CorsixTH
    make
    md_return_require="$md_build/CorsixTH/CorsixTH"
    cd "$md_build"
}

function install_corsixth() {
    make install
}

function game_data_corsixth() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    if [[ ! -f "$romdir/ports/$md_id/HOSP.exe" ]]; then
        downloadAndExtract "https://archive.org/download/HOSP_zip/HOSP.zip" "$romdir/ports/$md_id"
    fi
}

function configure_corsixth() {
    mkdir "$home/.config/CorsixTH"

    cat >"$md_inst/bin/corsix.sh" << _EOF_

#!/bin/bash
xset -dpms s off s noblank
matchbox-window-manager & /opt/retropie/ports/corsixth/bin/corsix-th
_EOF_

     chmod +x "$md_inst/bin/corsix.sh"
     moveConfigDir "$home/.config/CorsixTH" "$md_conf_root/$md_id"
     addPort "$md_id" "corsixth" "CorsixTH - Theme Hospital Engine" "$md_inst/bin/corsix.sh"

cat >"$md_conf_root/$md_id/config.txt" << _EOF_

theme_hospital_install = [[$romdir/ports/$md_id]]

_EOF_


    [[ "$md_mode" == "install" ]] && game_data_corsixth
    [[ "$md_mode" == "remove" ]] && return

}
