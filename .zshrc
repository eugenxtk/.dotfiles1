# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up base for local enviroment
export BASE_EXECUTED=~/.dotfiles/base.sh
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
	if ! [[ -z $1 ]] 
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
	
export NIX_PACKAGES=(
	git
	neovim
        tmux
	stow
	fzf
        fd
        ripgrep
	bat
        tree
	xclip

	python3-3.11
	python312Packages.pip
)

export NIX_INSTALLED=$(nix-env -q)

for pkg ("$NIX_PACKAGES[@]")
	if ! [[ $NIX_INSTALLED == *$pkg* ]]; then
		echo "Installing $pkg package..."
		nix-env -iA "nixpkgs.$pkg"
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
