# Nushell Environment Config File

use std assert
use std/util "path add"

$env.ON_ANDROID = ((sys host).long_os_version | str contains "Android")

$env.NUPM_HOME = ($nu.home-path | path join ".nupm")
$env.NUX_HOME = ($nu.home-path | path join ".nux")

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
  ($nu.default-config-dir | path join 'scripts')
  ($env.NUPM_HOME | path join "modules")
  ...($env.NUX_HOME | path join "packages/*/*/lib" | glob $in)
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

$env.GOBIN = ($nu.home-path | path join '.go/bin')

$env.MANPAGER = r#'sh -c 'sed -u -e "s/\\x1B\[[0-9;]*m//g; s/.\\x08//g" | bat -p -lman''#

#$env.COM_MOJANG = ($nu.home-path | path join ".local/share/mcpelauncher/games/com.mojang/")
$env.COM_MOJANG = ($nu.home-path | path join ".var/app/io.mrarm.mcpelauncher/data/mcpelauncher/games/com.mojang")

path add ($env.NUX_HOME | path join 'scripts')
path add '/usr/local/flutter/bin'
path add '/usr/local/texlive/2024/bin/x86_64-linux'
path add '/usr/local/eww/target/release'
path add '/usr/local/ols'
path add '/usr/local/MCCompiledSource/mc-compiled-language-server/bin/Release/net9.0'
path add '/usr/local/mcpelauncher-extract/build'
path add '/usr/lib/jvm/java-24-openjdk/bin'
path add ($nu.home-path | path join '.local/share/nvim/mason/packages/java-language-server')
path add ($nu.home-path | path join '.local/bin')
path add ($nu.home-path | path join '.nimble/bin')
path add ($nu.home-path | path join '.cargo/bin')
path add ($nu.home-path | path join '.go/bin')
path add ($nu.home-path | path join '.bun/bin')
path add ($nu.home-path | path join '.deno/bin')
path add ($nu.home-path | path join '.local/share/gem/ruby/3.3.0/bin')
path add ($nu.home-path | path join '.local/share/coursier/bin/')
path add ($nu.home-path | path join 'Programs/clion-2024.2.2/bin')
path add ($nu.home-path | path join 'Programs/idea-IU-243.26053.27/bin')
path add ($nu.home-path | path join 'Programs/zig')
path add ($nu.home-path | path join 'Projects/zls/zig-out/bin')
path add ($nu.home-path | path join 'Projects/wi')
path add ($env.DEVKITPRO | path join 'tools/bin')
path add ($env.DEVKITARM | path join 'bin')
path add ($env.ANDROID_HOME | path join 'platform-tools')
path add ($env.WASMTIME_HOME | path join 'bin')
path add ($env.NUPM_HOME | path join "scripts")

do {
  const secrets_path = ($nu.default-config-dir | path join 'secrets.nu')
  source-env (if ($secrets_path | path exists) { $secrets_path } else { null })
}

use ($nu.home-path | path join ".nupm/nupm")
use ($nu.home-path | path join ".nux/packages/Nux/0.1.0/exe/nux")

if (which nvim | is-not-empty) {
  $env.EDITOR = "nvim"
} else if (which hx | is-not-empty) {
  $env.EDITOR = "hx"
}

zoxide init nushell | save -f ~/.zoxide.nu
