install:
	stow --dotfiles -v -t $(HOME) .

prepare:
	git clone --depth 1 https://github.com/nushell/nu_scripts.git /tmp/nu_scripts
	mkdir -p $(HOME)/Themes
	rm -rf $(HOME)/Themes/nu
	mv /tmp/nu_scripts/themes $(HOME)/Themes/nu
	rm -rf /tmp/nu_scripts
