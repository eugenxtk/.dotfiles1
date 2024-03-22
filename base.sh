#!/bin/bash

# Implement update functionality: remove and install from scratch
export NIX_FILES="/nix ~/.nix* ~/.local/state/nix"
export ANTIGEN_FILES="~/.antigen ~/.antigen.zsh"
export DOTFILES="~/.dotfiles"

export INSTALLATION_SCRIPT="bash $(cd ~ && rm -rf ~/.dotfiles && git clone https://github.com/eugenxtk/.dotfiles.git ~/.dotfiles && bash ~/.dotfiles/base.sh)"

alias dotfiles-update="sudo rm -rf $NIX_FILES $ANTIGEN_FILES $DOTFILES && sudo apt remove zsh && $INSTALLATION_SCRIPT"

NIX_PROFILE=~/.nix-profile

if ! [[ -L "$NIX_PROFILE" ]]; then
        echo "Download Nix and packages..."
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi

ZSHRC=~/.dotfiles/.zshrc
ZSHRC_SYMLINK=~/.zshrc

if [[ -e $ZSHRC_SYMLINK ]]; then
        rm $ZSHRC_SYMLINK
fi
ln -s $ZSHRC $ZSHRC_SYMLINK

ANTIGEN=~/antigen.zsh
ANTIGEN_REMOTE=git.io/antigen

if ! [[ -e $ANTIGEN ]]; then
        echo "Installing Antigen..."
        curl -L $ANTIGEN_REMOTE > $ANTIGEN
fi

if ! [[ $(command -v zsh) == *zsh* ]]; then
        echo "Installing ZSH..."
        sudo apt install zsh
fi

if ! [[ $SHELL == *zsh* ]]; then
        echo "Setting up ZSH as default shell..."
        sudo sh -c "echo $(which zsh) >> /etc/shells"
        sudo chsh -s "$(command -v zsh)" "${USER}"
        exit 1
fi
