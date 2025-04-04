#!/bin/sh

xrdb merge ~/.Xresources 
xbacklight -set 10 &
feh --bg-scale "$HOME/Pictures/Wallpapers/AnimeOasis.jpg" &
xset r rate 400 20 &
picom &

nu ~/.config/chadwm/scripts/bar.nu &
while type chadwm >/dev/null; do chadwm && continue || break; done
