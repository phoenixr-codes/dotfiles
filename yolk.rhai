// vim: set syntax=javascript :
export let data = #{
    for_vcs: LOCAL,
};
export let eggs = #{
    bat: #{ targets: "~/.config/bat" },
    nvim: #{ targets: "~/.config/nvim" },
    neofetch: #{ targets: "~/.config/neofetch" },
    rofi: #{ targets: "~/.config/rofi" },
    kitty: #{ targets: "~/.config/kitty" },
    mklicense: #{ targets: "~/.config/mklicense" },
    nushell: #{ targets: "~/.config/nushell" },
    starship: #{ targets: #{ "starship.toml": "~/.config/starship.toml" }, templates: ["starship.toml"] },
};
