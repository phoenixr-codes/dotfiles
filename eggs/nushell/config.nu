# Nushell Config File
#
# version = "0.88.1"

source keybindings.nu
use theme.nu

$env.config = {
  show_banner: false
  rm: {
    always_trash: ("trash-support" in (version).features and $nu.os-info.name not-in ["android", "ios"])
  }
  error_style: "fancy"
  completions: {
    external: {
      max_results: 20
    }
  }
  hooks: {
    display_output: "if (term size).columns >= 100 { table --icons --expand } else { table --icons }"
  }
  cursor_shape: {
    emacs: "line"
  }
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
  use_kitty_protocol: ("kitty" in ($env.TERM? | default "")) # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
}

theme apply

# Launches the yazi file browser.
def --env y [
  ...args # Arguments passed to yazi as-is
] {
	let tmp = mktemp -t "yazi-cwd.XXXXXX"
	yazi ...$args --cwd-file $tmp
	let cwd = open $tmp
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Creates a new file or directory from a template in ~/Templates.
def scaf [
  dest: path = .
]: nothing -> nothing {
  let templates_dir = $nu.home-dir | path join Templates
  let prompt = "Select a template"
    | ansi gradient --fgstart '0x40c9ff' --fgend '0xe81cff'
  $templates_dir
    | path join (ls $templates_dir
      | get name
      | path basename
      | input list $prompt)
    | cp -r $in $dest
}

source ~/.zoxide.nu # TODO: might not exist
source aliases.nu
#source completions.nu

source init.nu
source prelude.nu
