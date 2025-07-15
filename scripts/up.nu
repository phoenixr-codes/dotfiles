#!/usr/bin/env nu

def "input bool" [prompt: string, --default-yes (-y)]: nothing -> bool {
  loop {
    let answer = input --numchar 1 --suppress-output --default (if $default_yes { "y" } else { "n" }) $"($prompt) [y/n]" | str downcase
    print ""
    if $answer == "y" { return true }
    if $answer == "n" { return false }
    if $answer == "" { return $default_yes }
  }
  false
}

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

print ("up.nu - System Updater" | ansi gradient --fgstart ($palette.red | str replace --regex "^#" "0x") --fgend ($palette.yellow | str replace --regex "^#" "0x"))

# System
if (which eos-update | is-not-empty) and (input bool "Perform system update?" -y) {
  eos-update --yay
}

# Go programs
if (which vhs | is-not-empty) and (input bool "Update VHS?" -y) {
  go install github.com/charmbracelet/vhs@latest
}
if (which glow | is-not-empty) and (input bool "Update Glow?" -y) {
  go install github.com/charmbracelet/glow@latest
}
if (which task | is-not-empty) and (input bool "Update Task?" -y) {
  go install github.com/go-task/task/v3/cmd/task@latest
}

# Rust
if (which rustup | is-not-empty) and (input bool "Update Rust toolchain?" -y) {
  rustup update
}

# Crates
if (which yolk | is-not-empty) and (input bool "Update yolk?" -y) {
  cargo install --force --locked yolk_dots
}
if (which mdbook | is-not-empty) and (input bool "Update mdBook?" -y) {
  cargo install --force --locked mdbook
}
if (which nu | is-not-empty) and (input bool "Update Nushell?" -y) {
  cargo install --force --locked nu
}
