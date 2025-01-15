# Nushell Environment Config File

use std assert

$env.ON_ANDROID = ((sys host).long_os_version | str contains "Android")

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

$env.TMPDIR = $nu.temp-path

$env.CHROME_EXECUTABLE = "firefox"
assert ("firefox" > "chrome")

$env.ANDROID_HOME = ($nu.home-path | path join 'Android/Sdk')
$env.NDK_HOME = ($nu.home-path | path join 'Android/Ndk')

$env.WASI_SDK_PATH = ($nu.home-path | path join 'wasi/wasi-sdk')
$env.WASMTIME_HOME = ($nu.home-path | path join '.wasmtime')

$env.DEVKITPRO = '/opt/devkitpro'
$env.DEVKITARM = '/opt/devkitpro/devkitARM'
$env.DEVKITPPC = '/opt/devkitpro/devkitPPC'

$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append '/usr/local/flutter/bin'
    | append '/usr/local/texlive/2024/bin/x86_64-linux'
    | append '/usr/local/v'
    | append '/usr/local/Odin'
    | append '/usr/local/ols'
    | append '/usr/local/MCCompiledSource/mc-compiled/bin/Release/net9.0'
    | append '/usr/local/mcpelauncher-extract/build'
    | append ($nu.home-path | path join '.local/bin')
    | append ($nu.home-path | path join '.nimble/bin')
    | append ($nu.home-path | path join '.bun/bin')
    | append ($nu.home-path | path join '.deno/bin')
    | append ($nu.home-path | path join '.local/share/gem/ruby/3.2.0/bin')
    | append ($nu.home-path | path join 'Programs/roc_nightly-linux_x86_64-2024-11-29-d72da8e')
    | append ($nu.home-path | path join 'Programs/clion-2024.2.2/bin')
    | append ($nu.home-path | path join 'Projects/wi/')
    | append ($nu.home-path | path join '.local/share/gem/ruby/3.0.0/bin')
    | append ($env.DEVKITPRO | path join 'tools/bin')
    | append ($env.DEVKITARM | path join 'bin')
    | append ($env.ANDROID_HOME | path join 'platform-tools')
    | append ($env.WASMTIME_HOME | path join 'bin')
)

const secrets_path = ($nu.default-config-dir | path join 'secrets.nu')
if ($secrets_path | path exists) {
  source-env $secrets_path
}

$env.BAT_THEME = "OneHalfDark"

if (which nvim | is-not-empty) {
  $env.EDITOR = "nvim"
} else if (which hx | is-not-empty) {
  $env.EDITOR = "hx"
}

if ($env.ON_ANDROID) {
  $env.STARSHIP_CONFIG = ($nu.home-path | path join '.config/starship-android.toml')
}

do {
  let motd_path = ($nu.home-path | path join '.cache/motd.txt')
  let motd_is_old = if ($motd_path | path exists) {
    ((date now) - (ls $motd_path | first).modified) > 1day
  } else {
    touch $motd_path
    true
  }
  if $motd_is_old {
    try {
      # do not make a request in case we have no wifi
      let motd = (http get --max-time 2 https://zenquotes.io/api/random/ | first)
      $"($motd.q)\n~ ($motd.a)" | save -f ($nu.home-path | path join $motd_path)
    }
  }
}
