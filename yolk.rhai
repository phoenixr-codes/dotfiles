// vim: set syntax=javascript :
export let data = #{
    for_vcs: LOCAL,
    theme: "Catppuccin Mocha",
};
export let eggs = #{
    bat: #{ targets: "~/.config/bat" },
    git: #{ targets: "~/.config/git" },
    nvim: #{ targets: "~/.config/nvim" },
    neofetch: #{ targets: "~/.config/neofetch" },
    rofi: #{ targets: "~/.config/rofi" },
    kitty: #{ targets: "~/.config/kitty", strategy: "merge" },
    mklicense: #{ targets: "~/.config/mklicense" },
    nushell: #{ targets: "~/.config/nushell", templates: ["config.nu"], strategy: "merge" },
    starship: #{ targets: #{ "starship.toml": "~/.config/starship.toml" }, templates: ["starship.toml"] },
    hushlogin: #{ targets: #{ ".hushlogin": "~/.hushlogin" }, enabled: SYSTEM.platform == "Android" },
    dunst: #{ targets: "~/.config/dunst", templates: ["dunstrc"] },
    waifufetch: #{ targets: "~/.config/waifufetch" },
};
