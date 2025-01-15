#!/usr/bin/env nu

git clone --depth 1 https://github.com/nushell/nu_scripts.git ($nu.default-config-dir | path join scripts)
