# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up base for local enviroment
BASE_EXECUTED=~/.dotfiles/base.sh
chmod +x $BASE_EXECUTED && $BASE_EXECUTED

. ~/.nix-profile/etc/profile.d/nix.sh

source ~/antigen.zsh

# Aliases for frequently used commands (\'command' to use original command instead of alias)
alias vim="nvim"
alias ls="clear && ls -la --color"

export BAT_THEME=1337
alias cat="bat --paging=never"
alias pcat="bat -r 0:20"
alias ccat="bat --paging=never --style=plain"

xxclip()
{
	if [[ ! -z $1 ]]; 
	then
		xclip -selection clipboard -i < $1	
	else
		echo "You should pass filename as an argument."
	fi
}

# Bindkeys to emulate Windows and Vim CTRL behaviour
bindkey '^H' backward-kill-word
bindkey ";5C" forward-word
bindkey ";5D" backward-word
# bindkey CTRL+D
# bindkey CTRL+U

# Install Nix packages

typeset -A NIX_PACKAGES
NIX_PACKAGES=(
	git git
	neovim neovim
	tmux tmux
	gnumake gnumake
	stow stow
	fzf fzf
        fd fd
        ripgrep ripgrep
	bat bat
        tree tree
	xclip xclip
	python312 python3-3.12
	python312Packages.pip python3.12-pip
)

for key ("${(@k)NIX_PACKAGES}"); do
	local PKG=$key 
	local PKG_NAME=$NIX_PACKAGES[$key]
	if ! [[ "$(nix-env -q)" == *$PKG_NAME* ]]; then
		echo "Installing $PKG package..."
		nix-env -iA "nixpkgs.$PKG"
	fi
done

# Install docker
DOCKER_INSTALL_SCRIPT="install-docker.sh"
if ! command -v docker > /dev/null; then
	sudo bash $DOCKER_INSTALL_SCRIPT
fi

# Stow files to push files from '.dotfiles' folder to '~'
cd ~/.dotfiles

stow git
stow nvim
stow tmux
stow p10k
stow git

# Install Antigen plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

unset ZSH_AUTOSUGGEST_USE_ASYNC

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux set -g status off
  exec tmux new-session -A -s main
fi
