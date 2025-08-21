# Basic API for a lot of things.

# Return the current brightness between 0 and 1.
export def brightness []: nothing -> float {
  let actual_brightness = (open /sys/class/backlight/intel_backlight/actual_brightness | into int)
  let maximum_brightness = (open /sys/class/backlight/intel_backlight/max_brightness | into int)
  $actual_brightness / $maximum_brightness
}

# Return the current volume between 0 and 1.
export def volume []: nothing -> float {
  (
    pactl --format=json list sinks
    | from json
    | last
    | get volume
    | get front-left
    | get value_percent
    | str replace "%" ""
    | into int
  ) / 100
}

# Return whether the volume is muted.
export def "volume muted" []: nothing -> bool {
  pactl --format=json list sinks
  | from json
  | last
  | get mute
}

# Return whether a connection to a WLAN is established.
export def "wlan connected" []: nothing -> bool {
  (open /sys/class/net/wl*/operstate | str trim) == "up"
}

# Return the SSID of the currently connected WLAN.
#
# This returns `null` when not connected to WLAN.
export def "wlan ssid" []: nothing -> string {
  let ssid = (iw dev wlan0 info | lines | find --no-highlight --regex "ssid")
  if ($ssid | is-empty) {
    null
  } else {
    $ssid | first | str trim | str replace --regex "^ssid " ""
  }
}

# Turn off WiFi.
export def "wlan disable" []: nothing -> nothing {
  nmcli radio wifi off
}

# Turn on WiFi.
export def "wlan enable" []: nothing -> nothing {
  nmcli radio wifi on
}

# Toggle WiFi status.
export def "wlan toggle" []: nothing -> nothing {
  if (wlan connected) {
    wlan disable
  } else {
    wlan enable
  }
}

# Return the current battery level between 0 and 1.
export def battery []: nothing -> float {
  (open /sys/class/power_supply/BAT0/capacity | into int) / 100
}

# Return whether the system is currently charging.
export def "battery charging" []: nothing -> bool {
  (open /sys/class/power_supply/BAT0/status | str trim) == "Charging"
}

# Return the estimated time until the system is fully charged.
#
# This may return `null`.
export def "battery remaining-until-full" []: nothing -> duration {
  let energy_full = (open /sys/class/power_supply/BAT0/energy_full | into int)
  let energy_now = (open /sys/class/power_supply/BAT0/energy_now | into int)
  let power_now = (open /sys/class/power_supply/BAT0/power_now | into int)
  if ($power_now == 0) {
    null
  } else {
    (($energy_full - $energy_now) / $power_now) | into duration --unit hr
  }
}

# Return the estimated time until the system runs out of battery.
#
# This may return `null`.
export def "battery remaining-until-empty" []: nothing -> duration {
  let energy_full = (open /sys/class/power_supply/BAT0/energy_full | into int)
  let energy_now = (open /sys/class/power_supply/BAT0/energy_now | into int)
  let power_now = (open /sys/class/power_supply/BAT0/power_now | into int)
  if ($power_now == 0) {
    null
  } else {
    ($energy_now / $power_now) | into duration --unit hr
  }
}
