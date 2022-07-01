#!/bin/sh

picom --experimental-backends &
nitrogen --restore &
xfce4-power-manager --daemon &
dunst &
discord &
unclutter &

# bar
~/src/dwm/scripts/status.sh &

# loop
while true; do
	dwm >/dev/null 2>&1
done

exec dwm
