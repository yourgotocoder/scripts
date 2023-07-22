#!/bin/bash

pactl set-sink-mute 1 0
pactl set-sink-volume 1 100%

SOUND_FILE="/home/cse/Downloads/alarm.wav"

while [ $SECONDS -lt 2 ]; do
  play  "${SOUND_FILE}" 
done
