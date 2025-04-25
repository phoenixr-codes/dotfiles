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
  let updates_result = (timeout 20 checkupdates | complete)
  match $updates_result.exit_code {
    0 => {
      let updates = ($updates_result | get stdout | lines | length)
      $"(fg $green)   ($updates) updates"
    },
    1 => $"(fg $green)   Updates unknown",
    2 => $"(fg $green)   Fully Updated"
  }
}

export def battery [] {
  let charging = (open /sys/class/power_supply/BAT0/status | str trim) == "Charging"
  let capacity = (open /sys/class/power_supply/BAT0/capacity | into int)

  let display = match $capacity {
    100  => {icon: {normal: "󰁹", charging: "󰂅"}, color: $green},
    90.. => {icon: {normal: "󰂂", charging: "󰂋"}, color: $green},
    80.. => {icon: {normal: "󰂁", charging: "󰂊"}, color: $green},
    70.. => {icon: {normal: "󰂀", charging: "󰢞"}, color: $green},
    60.. => {icon: {normal: "󰁿", charging: "󰂉"}, color: $green},
    50.. => {icon: {normal: "󰁾", charging: "󰢝"}, color: $green},
    40.. => {icon: {normal: "󰁽", charging: "󰂈"}, color: $green},
    30.. => {icon: {normal: "󰁼", charging: "󰂇"}, color: $green},
    20.. => {icon: {normal: "󰁻", charging: "󰂆"}, color: $peach},
    10.. => {icon: {normal: "󰁺", charging: "󰢜"}, color: $red},
    _    => {icon: {normal: "󰂎", charging: "󰢟"}, color: $red}
  }

  $"(fg $display.color) (if $charging { $display.icon.charging } else { $display.icon.normal }) (reset)(fg $white) ($capacity)% (reset)"
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
  $"(fg $black)(bg $blue)  (reset)(fg $white) ((sys mem).used)/((sys mem).total) (reset)"
}

def wlan_ssid [] {
  iw dev wlan0 info
  | lines
  | find --regex "ssid"
  | first
  | str trim
  | str replace --regex "^ssid " ""
}

export def wlan [] {
	match (open /sys/class/net/wl*/operstate | str trim) {
	  "up" => $"(fg $black)(bg $sapphire) 󰤨 (reset)(fg $white) (try { wlan_ssid } catch { "Connected" }) (reset)"
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
  xsetroot -name $"   ($updates) (battery) (brightness) (volume) (mem) (wlan) (datetime) (clock)"
  sleep 1sec
  $interval += 1
}
