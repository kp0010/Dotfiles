#!/bin/bash

hypridlePid=$(pidof hypridle)

echo $hypridlePid

if [ $hypridlePid ]; then
    kill $hypridlePid;
    notify-send "Hypridle Disabled"
else
    hyprctl dispatch exec hypridle
    notify-send "Hypridle Enabled"
fi
