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

  $"(fg $black)(bg $blue)  (fg $black)(bg $lavender) ($value) (reset)"
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
    $"(fg $black)(bg $red)   (reset)(fg $white) ($capacity)% (reset)"
  } else {
    $"(fg $black)(bg $green)   (reset)(fg $white) ($capacity)% (reset)"
  }
}

export def brightness [] {
  let brightness = $"((open /sys/class/backlight/intel_backlight/actual_brightness | into int) / (open /sys/class/backlight/intel_backlight/max_brightness | into int) * 100 | math round)%"

  $"(fg $black)(bg $peach) 󰖨 (reset)(fg $white) ($brightness) (reset)"
}

export def volume [] {
  let volume = (pactl --format=json list sinks | from json | last)
  let percent = ($volume.volume.front-left.value_percent | str replace "%" "" | into int)
  mut icon = ""
  if ($volume.mute) {
    $icon = " "
  } else if ($percent == 0) {
    $icon = " "
  } else if ($percent in 1..50) {
    $icon = " "
  } else {
    $icon = " "
  }
  $"(fg $black)(bg $pink) ($icon)(reset)(fg $white) ($percent)% (reset)"
}

export def mem [] {
  $"(fg $black)(bg $blue)  (reset)(fg $white) (free -h | awk '/^Mem/ { print $3 }' | sed s/i//g) (reset)"
}

export def wlan [] {
	match (open /sys/class/net/wl*/operstate | str trim) {
	  "up" => $"(fg $black)(bg $sapphire) 󰤨 (reset)(fg $white) Connected (reset)"
	  "down" => $"(fg $black)(bg $sapphire) 󰤭 (reset)(fg $white) Disconnected (reset)"
  }
}

export def clock [] {
  $"(fg $black)(bg $flamingo) 󱑆 (fg $black)(bg $rosewater) (date now | format date '%H:%M') (reset)"
}

export def datetime [] {
  $"(fg $black)(bg $flamingo) 󰃭 (fg $black)(bg $rosewater) (date now | format date '%a, %d.%m') (reset)"
}

mut interval = 0
mut updates = updates
loop {
  if ($interval == 0 or $interval mod 3600 == 0) {
    $updates = updates
  }
  xsetroot -name $"   ($updates) (battery) (brightness) (volume) (wlan) (datetime) (clock)"
  sleep 1sec
  $interval += 1
}
