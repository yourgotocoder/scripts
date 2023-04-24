#!/bin/bash
pactl set-sink-volume @DEFAULT_SINK@ 100%

SOUND_FILE="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"

while [ $SECONDS -lt 20 ]; do
  canberra-gtk-play -f "${SOUND_FILE}" 
done
