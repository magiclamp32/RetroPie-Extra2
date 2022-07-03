#!/bin/bash

# bgm123 kill script for RetroPie

source #autoconf

vcgencmd force_audio hdmi 0 >/dev/null && sleep 0.1
pkill "$music_player"
