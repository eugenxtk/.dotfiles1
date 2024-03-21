#!/bin/bash

DOTFILES=~/.dotfiles

NIX_PROFILE=~/.nix-profile

if ! [[ -L "$NIX_PROFILE" ]]; then
        echo "Download Nix and packages..."
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

if ! [[ $(command -v zsh) == *zsh* ]]; then
        echo "Installing ZSH..."
        sudo apt install zsh
fi

ZSHRC=$DOTFILES/.zshrc
ZSHRC_REMOTE=https://raw.githubusercontent.com/eugenxtk/.dotfiles/main/.zshrc

ZSHRC_SYMLINK=~/.zshrc

if ! [[ -e $ZSHRC ]]; then
        echo "Getting ZSHRC from remote repository..."
        curl -L $ZSHRC_REMOTE > $ZSHRC

        if [[ -e $ZSHRC_SYMLINK ]]; then
                rm $ZSHRC_SYMLINK
        fi
        ln -s $ZSHRC $ZSHRC_SYMLINK
fi

ANTIGEN=~/antigen.zsh
ANTIGEN_REMOTE=git.io/antigen

if ! [[ -e $ANTIGEN ]]; then
        echo "Installing Antigen..."
        curl -L $ANTIGEN_REMOTE > $ANTIGEN
fi

if ! [[ $SHELL == *zsh* ]]; then
        echo "Setting up ZSH as default shell..."
        command -v zsh | sudo tee -a /etc/shells
        sudo chsh -s "$(command -v zsh)" "${USER}"
        exit 1
fi
