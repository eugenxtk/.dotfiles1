#!/bin/bash

# Install Nix and packages
NIX_PROFILE=~/.local/state/nix/profiles/profile
NIX_PROFILE_SYMLINK=~/.nix-profile

if [ -L "$NIX_PROFILE_SYMLINK" ]; 
then
	echo "Nix already installed, if you want to reinstall it or install new packages configured in '.zshrc', delete '$NIX_PROFILE_SYMLINK' symlink and restart shell.\n" 
else
	sh <(curl -L https://nixos.org/nix/install) --daemon
	if ! [ -L "$NIX_PROFILE_SYMLINK" ]; then
		ln -s $NIX_PROFILE $NIX_PROFILE_SYMLINK	
	fi
	. ~/.nix-profile/etc/profile.d/nix.sh
	nix-env -iA \
		nixpkgs.zsh \
		nixpkgs.git \
		nixpkgs.neovim \
		nixpkgs.tmux \
		nixpkgs.stow \
		nixpkgs.fzf \
		nixpkgs.fd \
		nixpkgs.ripgrep \
		nixpkgs.bat 
fi

# Stow dotfiles
cd ~/.dotfiles

stow git
stow nvim
stow tmux
stow zsh

# Add ZSH as a login shell
if ! [[ $SHELL == *"zsh"* ]]; then
	command -v zsh | sudo tee -a /etc/shells
 	sudo chsh -s $(which zsh)
 	echo "You need to restart session to continue (if something went wrong, run this script again)"
 	exit 1
fi

# Install Neovim plugins
# nvim --headless +PlugInstall +q
