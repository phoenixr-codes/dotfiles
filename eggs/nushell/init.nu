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
  let fetchers = [
    # Bun-based project temporarily disabled as I uninstalled Bun.
    #"aurorafetch"
    #"waifufetch"
    "fetch"
    "neofetch"
  ]
  for fetcher in $fetchers {
    if (which $fetcher | is-not-empty) {
      try { run-external $fetcher } catch { continue }
      break
    }
  }
}

# Launch starship.
if (which starship | is-not-empty) {
  source starship.nu
}
