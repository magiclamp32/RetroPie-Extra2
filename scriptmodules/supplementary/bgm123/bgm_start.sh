#!/bin/bash

# bgm123 init script for RetroPie

source #autoconf

vcgencmd force_audio hdmi 1 >/dev/null && sleep 0.2
pgrep emulationstatio >/dev/null && mpg123 -Z "$music_dir/"*.[mM][pP]3 >/dev/null 2>&1
