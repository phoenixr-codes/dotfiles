# Code run at start-up that is not related to Nushell's configuration.

# This IIFE prevents bindings to be brought into scope
do {
  # Fetch a quote each day.
  let motd_dir = ($nu.home-dir | path join ".cache")
  let motd_path = ($motd_dir | path join "motd.txt")
  let motd_is_old = if ($motd_path | path exists) {
    ((date now) - (ls $motd_path | first).modified) > 1day
  } else {
    mkdir $motd_dir
    touch $motd_path
    true
  }
  if $motd_is_old {
    job spawn {
      let motd = try { http get --max-time 10sec https://zenquotes.io/api/today | first }
      if $motd != null {
        $"($motd.q)\n~ ($motd.a)" | save --force ($nu.home-dir | path join $motd_path)
      }
    }
  }

  # Launch neofetch.
  if (which aurorafetch | is-not-empty) {
    aurorafetch
  } else if (which waifufetch | is-not-empty) {
    waifufetch
  } else if (which neofetch | is-not-empty) {
    neofetch
  }
}

# Launch starship.
if (which starship | is-not-empty) {
  source starship.nu
}
