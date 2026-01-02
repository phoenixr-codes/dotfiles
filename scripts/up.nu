#!/usr/bin/env nu

# TODO: only install, when there is a more recent version

use std log

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
print "Select what you want to update"
[
  [icon color             label                   dependencies callback];
  ["󰒋"  $palette.pink     "System"                [eos-update] { yay --noconfirm }]

  [""  $palette.sapphire "VHS"                   [go]         { go install github.com/charmbracelet/vhs@latest }]
  [""  $palette.sapphire "Glow"                  [go]         { go install github.com/charmbracelet/glow@latest }]
  [""  $palette.sapphire "Task"                  [go]         { go install github.com/go-task/task/v3/cmd/task@latest }]
  [""  $palette.sapphire "ascii-image-converter" [go]         { go install github.com/TheZoraiz/ascii-image-converter@latest }]

  [""  $palette.sky      "Flutter"               [flutter]    { flutter upgrade }]
  [""  $palette.sky      "V"                     [v]          { v up }]
  [""  $palette.peach    "Rust"                  [rustup]     { rustup update }]
  [""  $palette.yellow   "Deno"                  [deno]       { deno upgrade }]
  [""  $palette.pink     "Bun"                   [bun]        { bun upgrade }]

  ["󰪯"  $palette.yellow   "Yolk"                  [cargo]      { cargo install --force --locked yolk_dots }]
  [""  $palette.peach    "mdBook"                [cargo]      { cargo install --force --locked mdbook }]
  [""  $palette.green    "Nushell"               [cargo]      { cargo install --force --locked nu }]
  [""  $palette.peach    "evcxr"                 [cargo]      { cargo install --force --locked evcxr_repl }]
  [""  $palette.sky      "Typst"                 [cargo]      { cargo install --force --locked typst-cli }]

  ["" $palette.yellow    "rofimoji"              [pipx]       { pipx install --force git+https://github.com/fdw/rofimoji.git }]
] | where { $in.dependencies | all { which $in | is-not-empty } }
  | each { $in | update label $"(ansi --escape {fg: $in.color})($in.icon) ($in.label)(ansi reset)" }
  | input list --multi --display label
  | each { |item| try { do $item.callback; log info $"Successfully updated ($item.label)"; true } catch { log error $"Failed to update ($item.label)"; false } }
  | print $"Updated ($in | where $it | length) of ($in | where not $it | length)"
