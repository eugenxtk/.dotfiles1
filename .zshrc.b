# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Option to include hidden files in completion list
setopt globdots

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

# Set up local enviroment
export INIT_EXECUTED=~/.dotfiles/init.sh

chmod +x $INIT_EXECUTED
$INIT_EXECUTED

# Fix freezes after accidental CTRL+S clicks
stty -ixon

# Stow dotfiles
cd ~/.dotfiles

if ! [[ -L ~/.zshrc ]]; then
	ln -s .zshrc ~/.zshrc
fi

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
