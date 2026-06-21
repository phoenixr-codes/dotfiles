def should-apply [
  theme_name: string
]: nothing -> bool {
  yolk eval $"data.theme == theme.($theme_name)" | into bool
}

# Apply the preferred theme.
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

# Apply the palenight theme.
export def "apply palenight" []: nothing -> nothing {
  source scripts/themes/nu-themes/material-palenight.nu
}

# Apply the Catppuccin Frappe theme.
export def "apply catppuccin-frappe" []: nothing -> nothing {
}

# Apply the Catppuccin Mocha theme.
export def "apply catppuccin-mocha" []: nothing -> nothing {
  source scripts/themes/nu-themes/catppuccin-mocha.nu
}

# Apply the Nord theme.
export def "apply nord" []: nothing -> nothing {
  source scripts/themes/nu-themes/nord.nu
}
