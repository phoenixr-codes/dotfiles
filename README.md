# dotfiles

## Requirements

- [Yolk][]

## Installation

```nushell
git clone https://github.com/phoenixr-codes/dotfiles ~/.config/yolk;
mkdir ~/.config/nushell;
touch ~/.config/nushell/secrets.nu;
yolk safeguard;
yolk sync
```

## Sync

```console
yolk sync
```

## TODO

- [ ] Bind fn keys.
- [ ] Configure emoji selection apps and localsend to float in dwm.
- [x] Only include `config.h` of dwm.
- [ ] Add eww configurations.
- [ ] Fix eww font and gap issue.
- [ ] Fix font in dwm bar.
- [x] Apply different colors to panels on dwm bar (again).
- [x] Add audio level/muted to dwm bar.
- [x] Different battery icon depending on percentage.
- [x] Improve colors in dwm bar.
- [x] Remove CPU and memory from dwm bar.

[Yolk]: https://elkowar.github.io/yolk/

