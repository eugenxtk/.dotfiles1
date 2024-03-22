# Set up base for local enviroment
export BASE_EXECUTED=~/base.sh
chmod +x $BASE_EXECUTED && $BASE_EXECUTED

. ~/.nix-profile/etc/profile.d/nix.sh

source ~/antigen.zsh

# Implement update functionality: remove and install from scratch
export NIX_FILES="/nix ~/.nix* ~/.local/state/nix"
export ANTIGEN_FILES="~/.antigen ~/.antigen.zsh"
export DOTFILES="~/.dotfiles"

export INSTALLATION_SCRIPT="bash $(cd ~ && rm -rf ~/.dotfiles && git clone https://github.com/eugenxtk/.dotfiles.git ~/.dotfiles && bash ~/.dotfiles/base.sh)"

alias dotfiles-update="sudo rm -rf $NIX_FILES $ANTIGEN_FILES $DOTFILES && sudo apt remove zsh && $INSTALLATION_SCRIPT"

# Aliases for frequently used commands (\'command' to use original command instead of alias)
alias vim="nvim"
alias ls="clear && ls -la --color"

export BAT_THEME=1337
alias cat="bat --paging=never"
alias pcat="bat -r 0:20"
alias pscat="bat --paging=never --style=plain"

# Bindkeys to emulate Windows and Vim CTRL behaviour
bindkey '^H' backward-kill-word
bindkey ";5C" forward-word
bindkey ";5D" backward-word
# bindkey CTRL+D
# bindkey CTRL+U

# Install Nix packages
nix-env -iA \
        nixpkgs.neovim \
        nixpkgs.tmux \
        nixpkgs.stow \
        nixpkgs.fzf \
        nixpkgs.fd \
        nixpkgs.ripgrep \
        nixpkgs.bat \
        nixpkgs.tree

# Stow files to push files from '.dotfiles' folder to '~'
cd ~/.dotfiles

stow git
stow nvim
stow tmux

# Install Antigen plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# antigen theme minimal

antigen apply
