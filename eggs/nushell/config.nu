# Nushell Config File
#
# version = "0.88.1"

use keybindings.nu

# {% if data.theme == "Palenight" %}
#<yolk> source scripts/themes/nu-themes/material-palenight.nu
#<yolk> if (which kitten | is-not-empty) {
  #<yolk> try { kitten themes palenight }
#<yolk> }
# {% end %}
# {% if data.theme == "Catppuccin Frappe" %}
#<yolk> source scripts/themes/nu-themes/catppuccin-frappe.nu
#<yolk> if (which kitten | is-not-empty) {
  #<yolk> try { kitten themes Catppuccin-Frappe }
#<yolk> }
# {% end %}
# {% if data.theme == "Catppuccin Mocha" %}
source scripts/themes/nu-themes/catppuccin-mocha.nu
if (which kitten | is-not-empty) {
  try { kitten themes Catppuccin-Mocha }
}
# {% end %}

$env.config = {
  show_banner: false
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {
    always_trash: (not ($env.ON_ANDROID)) # Android does not support trash
  }
  error_style: "fancy"
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "plaintext"
  }
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
      enable: true
      max_results: 20
      completer: null # check 'carapace_completer' above as an example
    }
  }
  cursor_shape: {
    emacs: line           # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
    vi_insert: block      # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
    vi_normal: underscore # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
  }
  footer_mode: 25 # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  buffer_editor: "" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  bracketed_paste: true # enable bracketed paste, currently useless on windows
  edit_mode: emacs # emacs, vi
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  use_kitty_protocol: false # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
  highlight_resolved_externals: false # true enables highlighting of external commands in the repl resolved by which.
  menus: [
    # Configuration for default nushell menus
    # Note the lack of source parameter
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "| "
      type: {
        layout: columnar
        columns: 4
        col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
    {
      name: history_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: list
        page_size: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
    {
      name: help_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: description
        columns: 4
        col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
        selection_rows: 4
        description_rows: 10
      }
      style: {
        text: green
        selected_text: green_reverse
        description_text: yellow
      }
    }
  ]
}

# Aliases
alias disfire = sudo systemctl stop firewalld
alias rr = java -jar ($nu.home-path | path join Programs rr.war)
alias mcc = mc-compiled
alias task = go-task

# Launches the default editor.
#
# This command respects virtual environments such as Poetry.
def --wrapped x [
  ...rest # Arguments passed to the editor as-is
] {
  if ("poetry.lock" | path exists) {
    poetry run $env.EDITOR ...$rest
  } else {
    run-external $env.EDITOR ...$rest
  }
}

# Launches the yazi file browser.
def --env y [
  ...args # Arguments passed to yazi as-is
] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

source init.nu
source completions.nu
use xx.nu
