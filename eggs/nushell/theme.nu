# TODO: only affects terminal

def should-apply [
  theme_name: string
]: nothing -> bool {
  yolk eval $"data.theme == theme.($theme_name)" | into bool
}

# Apply a theme on Nushell and Kitty.
export def apply [] {
  if (should-apply "palenight") {
    apply palenight
    return
  }

  if (should-apply "catppuccin_frappe") {
    apply catppuccin-frappe
    return
  }

  if (should-apply "catppuccin_mocha") {
    apply catppuccin-mocha
    return
  }

  if (should-apply "nord") {
    apply nord
    return
  }
}

export def "apply palenight" []: nothing -> nothing {
  source scripts/themes/nu-themes/material-palenight.nu
  try { kitten themes palenight }
}

export def "apply catppuccin-frappe" []: nothing -> nothing {
  try { kitten themes catppuccin-frappe }
}

export def "apply catppuccin-mocha" []: nothing -> nothing {
  source scripts/themes/nu-themes/catppuccin-mocha.nu
  try { kitten themes catppuccin-mocha }
}

export def "apply nord" []: nothing -> nothing {
  source scripts/themes/nu-themes/nord.nu
  try { kitten themes nord }
}
