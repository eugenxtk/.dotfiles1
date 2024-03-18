# Set up local enviroment
export INIT_EXECUTED=~/.dotfiles/init.sh

chmod +x $INIT_EXECUTED
$INIT_EXECUTED

# Implement update functionality
export NIX_PROFILE=~/.local/state/nix/profiles/profile
export NIX_PROFILE_SYMLINK=~/.nix-profile 

export DOTFILES=~/.dotfiles
export DOTFILES_INIT_EXECUTED="source <(curl -s https://raw.githubusercontent.com/eugenxtk/.dotfiles/main/init.sh)"

export ANTIGEN=~/antigen.zsh
export ANTIGEN_DIRECTORY=~/.antigen

alias dotfiles-update="rm -rf $NIX_PROFILE $NIX_PROFILE_SYMLINK $DOTFILES $ANTIGEN $ANTIGEN_DIRECTORY && $DOTFILES_INIT_EXECUTED"

# Fix freezes after accidental CTRL+S clicks
# stty -ixon

# Stow dotfiles
cd ~/.dotfiles

stow git
stow nvim
stow tmux

# Install Neovim plugins
# nvim --headless +PlugInstall +q

# Aliases for frequently used commands (\'command' to use original command instead of alias)
alias vim="nvim"
alias ls="clear && ls -la --color"

export BAT_THEME=1337
alias cat="batcat --paging=never"
alias pcat="batcat -r 0:20"

# Bindkeys to emulate Windows and Vim CTRL behaviour
bindkey '^H' backward-kill-word
bindkey ";5C" forward-word
bindkey ";5D" backward-word
# bindkey CTRL+D
# bindkey CTRL+U

# Install Antigen as ZSH plugin manager with plugins
export ANTIGEN_REMOTE=git.io/antigen

if ! [[ -e $ANTIGEN ]]; then
	echo "Installing Antigen as plugin manager with plugins..."
	curl -L $ANTIGEN_REMOTE > $ANTIGEN 
fi

source $ANTIGEN

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions 
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme minimal 

antigen apply

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi
