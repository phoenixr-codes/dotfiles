#!/usr/bin/env nu

# System
if (which eos-update | is-not-empty) {
  eos-update
}

# charm apps
if (which vhs | is-not-empty) {
  go install github.com/charmbracelet/vhs@latest
}
if (which glow | is-not-empty) {
  go install github.com/charmbracelet/glow@latest
}

# Rust
if (which rustup | is-not-empty) {
  rustup update
}

# Crates
if (which yolk | is-not-empty) {
  cargo install --locked yolk
}
if (which mdbook | is-not-empty) {
  cargo install --locked mdbook
}
