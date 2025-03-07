#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-scale /home/jonas/Pictures/Wallpapers/AnimeOasis.jpg &
xset r rate 400 20 &
picom &

#dash ~/.config/chadwm/scripts/bar.sh &
nu ~/.config/chadwm/scripts/bar.nu &
while type chadwm >/dev/null; do chadwm && continue || break; done
