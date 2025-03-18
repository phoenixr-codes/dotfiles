#!/usr/bin/env nu

# Fetch a quote each day.
do {
  let motd_path = ($nu.home-path | path join '.cache/motd.txt')
  let motd_is_old = if ($motd_path | path exists) {
    ((date now) - (ls $motd_path | first).modified) > 1day
  } else {
    touch $motd_path
    true
  }
  if $motd_is_old {
    try {
      # do not make a request in case we have no wifi
      let motd = (http get --max-time 2sec https://zenquotes.io/api/random/ | first)
      $"($motd.q)\n~ ($motd.a)" | save -f ($nu.home-path | path join $motd_path)
    }
  }
}

# Launch neofetch.
if (which neofetch | is-not-empty) {
    neofetch
}

# Launch starship.
source starship.nu
