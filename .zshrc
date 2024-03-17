# Set up local enviroment
export INIT_EXECUTED=~/.dotfiles/init.sh

chmod +x $INIT_EXECUTED
$INIT_EXECUTED

# Fix freezes after accidental CTRL+S clicks
stty -ixon

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
alias cat="batcat --paging=never --theme=1337"
alias pcat="batcat -r 0:20 --theme=1337"

# Bindkeys to emulate Windows CTRL behaviour
bindkey '^H' backward-kill-word
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# Install Antigen as ZSH plugin manager with plugins
if ! [[ -e ~/antigen.zsh ]]; then
	curl -L git.io/antigen > ~/antigen.zsh
fi

source ~/antigen.zsh

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions 
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme minimal 

antigen apply

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi
