#!/bin/bash

# A script for RetroPie to pause and restart background music with fade effect.
#
# Detects player status and toggles playback automatically.
# Force mode with -STOP or -CONT option.
#
# Inspired by original work from cyperghost (crcerror):
# https://github.com/crcerror/RetroPie-Shares/blob/master/BGM_vol_fade.sh
#

source #autoconf

# avoid multiple starts
wait=0
while [[ "$(pgrep -c -f $(basename $0))" -gt 1 ]]; do
    [[ "$wait" -gt 6 ]] && exit 1
    wait="$[$wait +1]"
    sleep 1
done

# get mixer channel and player name
readonly MIXER_CHANNEL="$mixer_channel"
readonly MUSIC_PLAYER="$music_player"

# command for amixer (use -M for mapped volume)
# don't quote $MIXER in commands when -M (or any params) are used
MIXER="amixer"
[[ "$mapped_volume" == "enabled" ]] && MIXER="amixer -M"
readonly MIXER

# get mixer volume
readonly VOLUME_RAW="$($MIXER get $MIXER_CHANNEL | grep -o '...%')"
readonly MIXER_VOLUME="${VOLUME_RAW//[![:digit:]]}"

# get player status
PLAYER_STATUS="$(ps -o state= -C $MUSIC_PLAYER 2>/dev/null)"
[[ -n "$1" ]] && PLAYER_STATUS="$1"
readonly PLAYER_STATUS

# declare fade volume and step size
fade_volume=""
volume_step=""

function setStep() {
    # set dynamic step size for true volume
    case "$fade_volume" in
        [1-4][0-9]|50) volume_step="5" ;;
        [5-7][0-9]|80) volume_step="3" ;;
        [8-9][0-9]|100) volume_step="1" ;;
        *) volume_step="5" ;;
    esac
}

function volumeZero() {
    $MIXER -q set "$MIXER_CHANNEL" 0%
}

function volumeReset() {
    $MIXER -q set "$MIXER_CHANNEL" "${MIXER_VOLUME}%"
}

# if flag -(s)top, or status=(r)unning or interruptable (s)leep
if [[ "${PLAYER_STATUS,,}" == *s* || "${PLAYER_STATUS,,}" == *r* ]]; then
    # fade out and stop player
    fade_volume="$MIXER_VOLUME"
    volume_step="$[$MIXER_VOLUME /20]"
    until [[ "$fade_volume" -le 10 ]]; do
        [[ "$mapped_volume" == "enabled" ]] || setStep
        fade_volume="$[$fade_volume -$volume_step]"
        $MIXER -q set "$MIXER_CHANNEL" "${fade_volume}%"
        sleep 0.1
    done
    volumeZero
    pkill -STOP "$MUSIC_PLAYER"
    sleep 0.5
    volumeReset

# else if flag -con(t) or status=s(t)opped
elif [[ "${PLAYER_STATUS,,}" == *t* ]]; then
    # restart player and fade in
    volumeZero
    sleep 0.5
    pkill -CONT "$MUSIC_PLAYER"
    fade_volume="10"
    volume_step="$[$MIXER_VOLUME /20]"
    until [[ "$fade_volume" -ge "$MIXER_VOLUME" ]]; do
        [[ "$mapped_volume" == "enabled" ]] || setStep
        fade_volume="$[$fade_volume +$volume_step]"
        $MIXER -q set "$MIXER_CHANNEL" "${fade_volume}%"
        sleep 0.2
    done
    volumeReset
fi
