#!/bin/bash

# 1. Install Nix and packages
NIX_PROFILE=~/.local/state/nix/profiles/profile
NIX_PROFILE_SYMLINK=~/.nix-profile 

if ! [[ -L "$NIX_PROFILE_SYMLINK" ]]; then 
	sh <(curl -L https://nixos.org/nix/install) --daemon
	if ! [[ -L $NIX_PROFILE_SYMLINK ]]; then
		ln -s $NIX_PROFILE $NIX_PROFILE_SYMLINK	
	fi
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

# 2. Sync with remote repository and 
DOTFILES=~/.dotfiles
DOTFILES_REMOTE=git@github.com:eugenxtk/.dotfiles.git

if ! [[ -d $DOTFILES ]]; then
	mkdir $DOTFILES 
	git clone $DOTFILES_REMOTE $DOTFILES
fi

# 3. Set up ZSH as default shell
if ! [[ $SHELL == *"zsh"* ]]; then
	command -v zsh | sudo tee -a /etc/shells
 	sudo chsh -s $(which zsh)
 	echo "Now ZSH is your default shell. You need to restart session to continue."
 	exit 1
fi
