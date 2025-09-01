#!/bin/bash

cliphist=/usr/bin/cliphist
rofi=/usr/bin/rofi
wlcopy=/usr/bin/wl-copy

export LANG=en_GB.UTF-8

$cliphist list | $rofi -theme '/home/kp/.config/rofi/launchers/type-1/style-11.rasi' -dmenu | $cliphist decode | $wlcopy
