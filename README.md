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

- [ ] Add eww configurations.
- [ ] Fix eww font and gap issue.
- [ ] Fix font in dwm bar.
- [x] Apply different colors to panels on dwm bar (again).
- [x] Add audio level/muted to dwm bar.
- [ ] Different battery icon depending on percentage.
- [ ] Improve colors in dwm bar.
- [ ] Remove CPU and memory from dwm bar.

[Yolk]: https://elkowar.github.io/yolk/

