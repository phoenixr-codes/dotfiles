#!/usr/bin/env nu

#        /$$             /$$      /$$$$$$  /$$ /$$                    
#       | $$            | $$     /$$__  $$|__/| $$                    
#   /$$$$$$$  /$$$$$$  /$$$$$$  | $$  \__/ /$$| $$  /$$$$$$   /$$$$$$$
#  /$$__  $$ /$$__  $$|_  $$_/  | $$$$    | $$| $$ /$$__  $$ /$$_____/
# | $$  | $$| $$  \ $$  | $$    | $$_/    | $$| $$| $$$$$$$$|  $$$$$$ 
# | $$  | $$| $$  | $$  | $$ /$$| $$      | $$| $$| $$_____/ \____  $$
# |  $$$$$$$|  $$$$$$/  |  $$$$/| $$      | $$| $$|  $$$$$$$ /$$$$$$$/
#  \_______/ \______/    \___/  |__/      |__/|__/ \_______/|_______/ 

const title = "phoenixR's dotfiles"

const palette = {
  rosewater: "#f5e0dc"
  flamingo:  "#f2cdcd"
  pink:      "#f5c2e7"
  mauve:     "#cba6f7"
  red:       "#f38ba8"
  maroon:    "#eba0ac"
  peach:     "#fab387"
  yellow:    "#f9e2af"
  green:     "#a6e3a1"
  teal:      "#94e2d5"
  sky:       "#89dceb"
  sapphire:  "#74c7ec"
  blue:      "#89b4fa"
  lavender:  "#b4befe"
}

# Emit a log message in error level.
def "log error" [message: string]: nothing -> nothing {
  print --stderr $"⚠️ (ansi --escape {fg: $palette.red})($message)(ansi reset)"
}

# Emit a log message in warning level.
def "log warn" [message: string]: nothing -> nothing {
  print --stderr $"⚠️ (ansi --escape {fg: $palette.yellow})($message)(ansi reset)"
}

# Emit a log messages in info level.
def "log info" [message: string]: nothing -> nothing {
  print $"ℹ️ (ansi --escape {fg: $palette.teal})($message)(ansi reset)"
}

# Emit a log message in success level.
def "log success" [message: string]: nothing -> nothing {
  print $"✅ (ansi --escape {fg: $palette.green})($message)(ansi reset)"
}

def ask [message: string, --default: string]: nothing -> string {
  input $"❔ ($message) " --default $default
}

# Remove common indentation of lines.
def "str dedent" []: string -> string {
  let actual_lines = $in
    | lines
    | skip while { str trim | is-empty }

  let common_indent = $actual_lines
    | each { split chars | take while { |ch| $ch == " " } }
    | each { length }
    | math min

  $in
    | lines
    | each { |line| $line | str substring $common_indent.. }
    | str join "\n"
}

# Installer script for phoenixR's dotfiles.
def main [
  --simulate (-n) # Do not actually make any filesystem changes
]: nothing -> nothing {
  if ($simulate) {
    log info "Simulate mode is on"
  }

  print ($title | ansi gradient --fgstart ($palette.red | str replace --regex "^#" "0x") --fgend ($palette.yellow | str replace --regex "^#" "0x"))
  print $"Source Code: ("https://github.com/phoenixr-codes/dotfiles" | ansi link)"
  print ($"
    This script installs dotfiles on the system. This script is (ansi bo)not responsible for any loss(ansi reset)
    of data on your system. Invoke this script with `--help` to see more options. Press enter to confirm." | str dedent)
  input

  # Check for git
  if (which git | is-empty) {
    log error "git seems to be not installed"
    exit 1
  }

  # Install yolk
  if (which yolk | is-empty) {
    log info "yolk seems not to be installed"
    input "Press enter to confirm installation of yolk"
    if (which cargo | is-empty) {
      log error "cargo seems to be not installed"
      exit 1
    }
    if not $simulate {
      cargo install yolk_dots
    }
  } else {
    log info "yolk already installed"
  }

  # Clone dotfiles repo
  let target_dir_default = $env.HOME | path join ".config/yolk"
  let target_dir = ask "Where do you want to install the dotfiles?" --default $target_dir_default
  if not $simulate {
    if ($target_dir | path exists) {
      log info "Updating dotfiles repository"
      yolk git -C $target_dir pull
    } else {
      log info "Cloning dotfiles repository"
      git clone --depth 1 --recurse-submodules https://github.com/phoenixr-codes/dotfiles $target_dir
      yolk safeguard
    }
  }

  # Perform backup
  let backup_dir_default = $env.HOME | path join $".dotfiles_backup_(random uuid -v 7)"
  let backup_dir = ask "Where do you want to store the backup?" --default $backup_dir_default
  log info "Performing backup of targeted files and directories"
  if not $simulate {
    mkdir $backup_dir
  }
  let eggs = yolk eval "eggs.to_json()" | from json | transpose "name" "data"
  for egg in $eggs {
    let targets = $egg.data.targets
    let path = if ($targets | describe -d | get type) == record { $targets | values | first } else { $targets } | path expand --no-symlink
    log info $"Backing up ($path)"
    if not $simulate {
      if ($path | path type) == "symlink" {
        rm $path
      } else if ($path | path exists) {
        mv $path $backup_dir
      }
    }
  }

  # Sync dotfiles
  log info "Syncing dotfiles"
  if not $simulate {
    yolk sync
  }

  # Create extra files
  log info "Creating extra files"
  if not $simulate {
    touch ~/.config/nushell/secrets.nu
  }

  log success "Successfully installed dotfiles"
}
