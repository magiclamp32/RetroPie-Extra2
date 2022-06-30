#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="bgm123"
rp_module_desc="Straightforward background music player using mpg123"
rp_module_help="Place your MP3 files in $datadir/bgm"
rp_module_section="exp"
rp_module_flags="!all rpi"

function depends_bgm123() {
    getDepends mpg123
}

function _autostart_bgm123() {
    echo "$configdir/all/autostart.sh"
}

function _bashrc_bgm123() {
    echo "$home/.bashrc"
}

function _onstart_bgm123() {
    echo "$configdir/all/runcommand-onstart.sh"
}

function _onend_bgm123() {
    echo "$configdir/all/runcommand-onend.sh"
}

function _gamelist_bgm123() {
    local xmlfile="$datadir/retropiemenu/gamelist.xml"
    [[ -f "$xmlfile" ]] || xmlfile="$configdir/all/emulationstation/gamelists/retropie/gamelist.xml"
    echo "$xmlfile"
}

function install_bin_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"
    local gamelist
    gamelist="$(_gamelist_bgm123)"

    local configfile="$configdir/all/$md_id.cfg"
    local fadescript="bgm_vol_fade.sh"
    local share="$datadir/bgm"
    local file

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        # preserve original file versions
        if [[ -f "$file" && ! -f "$file.old.$md_id" ]]; then
            cp -v "$file" "$file.old.$md_id"
            chown $user:$user "$file.old.$md_id"
        fi
    done

    cat > "$configfile" << _EOF_
rootdir="$rootdir"
configdir="$configdir"
scriptdir="$scriptdir"
datadir="$datadir"
user="$user"
md_inst="$md_inst"
__backtitle="$__backtitle"
_EOF_
    chown $user:$user "$configfile"

    cp "$md_data/$fadescript" "$md_inst"

    cp "$md_data/menu.sh" "$md_inst/$md_id.sh"
    sed -i '/#fnocotua/d' "$md_inst/$md_id.sh"
    sed -i '/#autoconf/asource "'"$configfile"'" #fnocotua' "$md_inst/$md_id.sh"

    ln -sf "$md_inst/$md_id.sh" "$datadir/retropiemenu/$md_id.sh"
    cp -f "$md_data/icon.png" "$datadir/retropiemenu/icons/$md_id.png"
    chown -R $user:$user "$datadir/retropiemenu"

    if ! grep "<path>./$md_id.sh</path>" "$gamelist" >/dev/null; then
        xmlstarlet ed -L -s "/gameList" -t elem -n "gameTMP" \
          -s "//gameTMP" -t elem -n path -v "./$md_id.sh" \
          -s "//gameTMP" -t elem -n name -v "Background Music" \
          -s "//gameTMP" -t elem -n desc -v "Configure and control background music player. Enable or disable menu music while browsing and pause, resume, or skip current track." \
          -s "//gameTMP" -t elem -n image -v "./icons/$md_id.png" \
          -r "//gameTMP" -v "game" \
          "$gamelist"
    fi

    mkUserDir "$share"
    add_share_samba "bgm" "$share"
    restart_samba
}

function disable_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"
    local file

    # kill player now since .bashrc won't do it later
    (vcgencmd force_audio hdmi 0) >/dev/null
    pkill mpg123

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        if [[ -f "$file" ]]; then
            # backup file and attempt to remove any existing bgm config
            cp -f "$file" "$file.bak"
            chown $user:$user "$file.bak"
            sed -i '/#bgm/d' "$file"

            # if file is now empty, remove it
            [[ ! -s "$file" ]] && rm -f "$file"
        fi
    done
}

function remove_bgm123() {
    local gamelist
    gamelist="$(_gamelist_bgm123)"

    rm -f "$datadir/retropiemenu/$md_id.sh" "$datadir/retropiemenu/icons/$md_id.png"
    xmlstarlet ed -L -d "/gameList/game[contains(path,'$md_id.sh')]" "$gamelist"

    disable_bgm123
    remove_share_samba "bgm"
    restart_samba
}

function enable_bgm123() {
    local autostart
    autostart="$(_autostart_bgm123)"
    local bashrc
    bashrc="$(_bashrc_bgm123)"
    local onstart
    onstart="$(_onstart_bgm123)"
    local onend
    onend="$(_onend_bgm123)"

    local fadescript="$md_inst/bgm_vol_fade.sh"
    local file

    disable_bgm123

    for file in "$autostart" "$bashrc" "$onstart" "$onend"; do
        touch "$file"
        chown $user:$user "$file"
    done

    echo -e "$(echo -e 'while pgrep omxplayer >/dev/null; do sleep 1; done #bgm123\n((vcgencmd force_audio hdmi 1) >/dev/null; sleep 8; mpg123 -Z "'$datadir'/bgm/"*.[mM][pP]3 >/dev/null 2>&1) & #bgm123'; cat $autostart)" > "$autostart"
    echo '[[ "$(tty)" == "/dev/tty1" ]] && ((vcgencmd force_audio hdmi 0) >/dev/null; pkill mpg123) #bgm123' >> "$bashrc"
    echo 'bash "'"$fadescript"'" -STOP & #bgm123' >> "$onstart"
    echo '(sleep 1; "bash '"$fadescript"'" -CONT) & #bgm123' >> "$onend"
}

function configure_bgm123() {
    [[ "$md_mode" == "install" ]] && enable_bgm123
}

function gui_bgm123() {
    bash "$md_inst/$md_id.sh"
}
