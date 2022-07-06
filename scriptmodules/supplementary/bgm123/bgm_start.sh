#!/bin/bash

# bgm123 init script for RetroPie

source #autoconf

vcgencmd force_audio hdmi 1 >/dev/null && sleep 0.2
mpg123 -Z -@- >/dev/null 2>&1 < <(find "$music_dir" -type f -iname "*.mp3")
