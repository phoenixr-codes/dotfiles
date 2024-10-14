install:
	stow --dotfiles -v -t $(HOME) .

install-nu-scripts:
	git clone --depth 1 https://github.com/nushell/nu_scripts.git $(HOME)/nu_scripts

