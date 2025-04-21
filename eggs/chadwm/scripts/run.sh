#!/bin/sh

set_background() {
  # Use previous background if there is one.
  if [ -f ~/.fehbg ]; then
    "$HOME/.fehbg"
  else
    feh --bg-scale /usr/share/endeavouros/backgrounds/eos_wallpapers_community/Endy_vector_satelliet.png
  fi
}

xrdb merge ~/.Xresources 
xbacklight -set 10 &
set_background &
xset r rate 400 20 &
picom &

nu ~/.config/chadwm/scripts/bar.nu &
while type chadwm >/dev/null; do chadwm && continue || break; done
