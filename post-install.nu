#!/usr/bin/env nu

const nu_scripts_path = ($nu.default-config-dir | path join scripts)
if not ($nu_scripts_path | path exists) {
  git clone --depth 1 https://github.com/nushell/nu_scripts.git $nu_scripts_path
}

const secrets_path = ($nu.default-config-dir | path join 'secrets.nu')
touch $secrets_path

