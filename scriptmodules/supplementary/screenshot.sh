#!/usr/bin/env bash

# adapted from ZeroJay's RetroPie-Extra:
# https://github.com/zerojay/RetroPie-Extra

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="screenshot"
rp_module_desc="Universal Screenshot with Raspi2PNG"
rp_module_help="Usage: 'screenshot [destination]' over SSH. File saved to '$datadir/screenshots/(date)_(time).png' if no destination given.\n\nThis script is incompatible with the OpenGL driver."
rp_module_repo="git https://github.com/AndrewFromMelbourne/raspi2png.git master b3c5599"
rp_module_licence="MIT https://raw.githubusercontent.com/AndrewFromMelbourne/raspi2png/master/LICENSE"
rp_module_section="exp"

function depends_screenshot() {
    getDepends libpng-dev
}

function sources_screenshot() {
    gitPullOrClone
}

function build_screenshot() {
    make clean
    make
    md_ret_require="$md_build/raspi2png"
}

function install_screenshot() {
    md_ret_files=(
        'raspi2png'
        'LICENSE'
        'README.md'
    )
}

function script_screenshot() {
    # Create script to take screenshot over ssh
    cat > "$md_inst/$md_id.sh" << _EOF_
#!/bin/bash
dest="\$1"
[[ ! -n "\$dest" ]] && dest="$datadir/screenshots/\$(date +%Y%m%d_%H%M%S).png"
[[ -d "\$dest" ]] && dest="\$dest/\$(date +%Y%m%d_%H%M%S).png"
dest_fileext="\${dest##*.}"
[[ "\${dest_fileext,,}" != "png" ]] && dest="\$dest.png"
$md_inst/raspi2png -p "\$dest" && echo Saved "\$dest"
_EOF_

    chmod +x "$md_inst/$md_id.sh"
    ln -sf "$md_inst/$md_id.sh" /usr/local/bin/screenshot
}

function configure_screenshot() {
    if [[ "$md_mode" == "remove" ]]; then
        [[ -h /usr/local/bin/screenshot ]] && rm -f /usr/local/bin/screenshot
        remove_share_samba "screenshots"
        restart_samba
        return
    fi
    mkUserDir "$datadir/screenshots"
    script_screenshot
    add_share_samba "screenshots" "$datadir/screenshots"
    restart_samba
}
