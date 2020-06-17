#!/bin/bash
SSID=$(iwgetid -r)
if [[ -z $(echo $SSID | grep -x -f - ~/.scripts/approvedwifi.txt) ]]
then
  i3lock-fancy -t "" -n
fi
