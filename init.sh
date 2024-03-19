#!/bin/bash

NIX_PROFILE=~/.nix-profile 

if ! [[ -L "$NIX_PROFILE" ]]; then 
	echo "Download Nix and packages..."
	sh <(curl -L https://nixos.org/nix/install) --no-daemon
	. $NIX_PROFILE/etc/profile.d/nix.sh
	nix-env -iA \ 
		nixpkgs.zsh \
		nixpkgs.git \
		nixpkgs.neovim \
		nixpkgs.tmux \
		nixpkgs.stow \
		nixpkgs.fzf \
		nixpkgs.fd \
		nixpkgs.ripgrep \
		nixpkgs.bat \
		nixpkgs.tree
fi

DOTFILES=~/.dotfiles
DOTFILES_REMOTE=git@github.com:eugenxtk/.dotfiles.git

if ! [[ -d $DOTFILES ]]; then
	echo "Cloning remote repository..."
	git clone $DOTFILES_REMOTE $DOTFILES
fi

ZSHRC=$DOTFILES/.zshrc
ZSHRC_SYMLINK=~/.zshrc

if ! [[ -L $ZSHRC_SYMLINK ]]; then
	echo "Creating ZSH symlink..."
	ln -s $ZSHRC $ZSHRC_SYMLINK
fi

if ! [[ $SHELL == *"zsh"* ]]; then
	echo "Setting up ZSH as default shell..."
	command -v zsh | sudo tee -a /etc/shells
 	sudo chsh -s $(which zsh)
 	echo "Now ZSH is default shell. You need to restart session to continue."
 	exit 1
fi
	
