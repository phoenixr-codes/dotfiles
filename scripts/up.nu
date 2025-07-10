#!/usr/bin/env nu

# System
if (which eos-update | is-not-empty) {
  eos-update
}

# Go programs
if (which vhs | is-not-empty) {
  go install github.com/charmbracelet/vhs@latest
}
if (which glow | is-not-empty) {
  go install github.com/charmbracelet/glow@latest
}
if (which task | is-not-empty) {
  go install github.com/go-task/task/v3/cmd/task@latest
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
