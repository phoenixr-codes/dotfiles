#!/bin/sh

set_background() {
  # Use previous background if there is one.
  if [ -f ~/.fehbg ]; then
    "$HOME/.fehbg"
  else
    feh --bg-scale /usr/share/endeavouros/backgrounds/eos_wallpapers_community/Endy_vector_satelliet.png
  fi
}

load_bar() {
  bar_path=~/.config/chadwm/scripts/bar.nu
  old_modified=$(stat -c "%Y" "$bar_path")
  nu "$bar_path" &
  bar_pid=$!
  while true; do
    last_modified=$(stat -c "%Y" "$bar_path")
    if [ "$last_modified" -gt "$old_modified" ]; then
      kill "$bar_pid"
      wait "$bar_pid" 2>/dev/null
      nu "$bar_path" &
      bar_pid=$!
      old_modified="$last_modified"
    fi
    sleep 1
  done
}

xrdb merge ~/.Xresources 
xbacklight -set 10 &
set_background &
xset r rate 400 20 &
picom &
load_bar &

while type chadwm >/dev/null; do chadwm && continue || break; done
