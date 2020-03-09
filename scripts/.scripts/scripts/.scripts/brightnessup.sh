#!/bin/bash
BRIGHTNESS_CHANGE=100
BRIGHTNESS_PATH=/sys/class/backlight/intel_backlight/
CURR_BRIGHTNESS=$(cat "${BRIGHTNESS_PATH}brightness")
NEW_BRIGHTNESS=$(($CURR_BRIGHTNESS+$BRIGHTNESS_CHANGE))
MAX_BRIGHTNESS=$(cat "${BRIGHTNESS_PATH}max_brightness")
if [[ $NEW_BRIGHTNESS -gt $MAX_BRIGHTNESS ]]
then
  NEW_BRIGHTNESS=$MAX_BRIGHTNESS
fi
echo $NEW_BRIGHTNESS > "${BRIGHTNESS_PATH}brightness"
