#!/bin/bash

# bgm123 kill script for RetroPie

source #autoconf

vcgencmd force_audio hdmi 0 >/dev/null && sleep 0.1
pkill "$music_player"
[[ "$(ps -ostate= -C $music_player)" == "T" ]] && pkill -CONT "$music_player"
