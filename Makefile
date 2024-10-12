install:
	stow --dotfiles -v -t $(HOME) .

prepare:
	git clone --depth 1 https://github.com/nushell/nu_scripts.git $(TMPDIR)/nu_scripts
	mkdir -p $(HOME)/Themes
	rm -rf $(HOME)/Themes/nu
	mv $(TMPDIR)/nu_scripts/themes $(HOME)/Themes/nu
	rm -rf $(TMPDIR)/nu_scripts
