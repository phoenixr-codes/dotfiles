#!/usr/bin/env nu

# load colors
use ~/.config/chadwm/scripts/bar_themes/catppuccin.nu

def fg [color: string] {
  $"^c($color)^"
}

def bg [color: string] {
  $"^b($color)^"
}

def reset [] {
  "^d^"
}

export def cpu [] {
  let value = (grep -o "^[^ ]*" /proc/loadavg)

  $"(fg $black)(bg $darkblue)  (fg $black)(bg $blue) ($value) (reset)"
}

export def updates [] {
  let updates = (try { timeout 20 checkupdates err>|null | lines | length } catch { 0 })

  if ($updates > 0) {
    $"(fg $green)   ($updates) updates"
  } else {
    $"(fg $green)   Fully Updated"
  }
}

export def battery [] {
  let capacity = (open /sys/class/power_supply/BAT0/capacity | into int)

  if ($capacity < 10) {
    $"(fg $red)(bg $black)   (fg $black)(bg $red) ($capacity)% (reset)"
  } else {
    $"(fg $black)(bg $darkblue)   (fg $black)(bg $blue) ($capacity)% (reset)"
  }
}

export def brightness [] {
  let capacity = $"((open /sys/class/backlight/intel_backlight/actual_brightness | into int) / (open /sys/class/backlight/intel_backlight/max_brightness | into int) * 100 | math round)%"

  $"(fg $black)(bg $darkblue)  (fg $black)(bg $blue) ($capacity) (reset)"
}

export def mem [] {
  $"(fg $black)(bg $darkblue)  (fg $black)(bg $blue) (free -h | awk '/^Mem/ { print $3 }' | sed s/i//g) (reset)"
}

export def wlan [] {
	match (open /sys/class/net/wl*/operstate | str trim) {
	  "up" => $"(fg $black)(bg $darkblue) 󰤨 (fg $black)(bg $blue) Connected (reset)"
	  "down" => $"(fg $black)(bg $darkblue) 󰤭 (fg $black)(bg $blue) Disconnected (reset)"
  }
}

export def clock [] {
  $"(fg $black)(bg $darkblue) 󱑆 (fg $black)(bg $blue) (date now | format date '%H:%M') (reset)"
}

export def datetime [] {
  $"(fg $black)(bg $darkblue) 󰃭 (fg $black)(bg $blue) (date now | format date '%a, %d.%m') (reset)"
}

mut interval = 0
mut updates = updates
loop {
  if ($interval == 0 or $interval mod 3600 == 0) {
    $updates = updates
  }
  xsetroot -name $"   ($updates) (battery) (brightness) (cpu) (mem) (wlan) (datetime) (clock)"
  sleep 1sec
  $interval += 1
}
