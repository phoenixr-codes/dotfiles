#!/usr/bin/env nu

do {

# Fetch a quote each day.
let motd_dir = ($nu.home-path | path join ".cache")
let motd_path = ($motd_dir | path join "motd.txt")
let motd_is_old = if ($motd_path | path exists) {
  ((date now) - (ls $motd_path | first).modified) > 1day
} else {
  mkdir $motd_dir
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

# Launch neofetch.
let waifufetch_ran = if (which waifufetch | is-not-empty) {
  let output = (with-env {SHELL: $nu.current-exe} { waifufetch } | complete | get stdout)
  if ($output | str trim | is-empty) {
    false
  } else {
    print $output
    true
  }
} else {
    false
  }

if (not $waifufetch_ran and (which neofetch | is-not-empty)) {
  neofetch
}

}

# Launch starship.
if (which starship | is-not-empty) {
  source starship.nu
}
