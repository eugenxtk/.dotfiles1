# Set up base for local enviroment
BASE_EXECUTED=~/.dotfiles/base.sh
chmod +x $BASE_EXECUTED && $BASE_EXECUTED

. ~/.nix-profile/etc/profile.d/nix.sh

source ~/antigen.zsh

# Aliases for frequently used commands 
alias vim="nvim"

alias ls="tput reset && ls -la --color"

cd() 
{
	if [[ -z $1 ]]; then
		echo "cd: You must specify directory"
		return
	fi
	if [[ ! -d $1 ]]; then
		echo "cd: Specified directory doesn't exist"
		return
	fi
	
	pwd
	builtin cd $1
	ls
}

alias cat="bat --paging=never"
alias pcat="bat -r 0:20"
alias ccat="bat --paging=never --style=plain"

export BAT_THEME=1337

xxclip()
{
	if [[ ! -z $1 ]]; 
	then
		xclip -selection clipboard -i < $1	
	else
		echo "You should pass filename as an argument."
	fi
}

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
	PKG=$key PKG_NAME=$NIX_PACKAGES[$key]
	if ! [[ "$(nix-env -q)" == *$PKG_NAME* ]]; then
		echo "Installing $PKG package..."
		nix-env -iA "nixpkgs.$PKG"
	fi
done

# Install Docker
DOCKER_INSTALL_SCRIPT="docker.sh"
if ! command -v docker > /dev/null; then
	sudo bash $DOCKER_INSTALL_SCRIPT
fi

# Install Tmux Plugin Manager
TPM_DIRECTORY=~/.dotfiles/tmux/.tmux/plugins/tpm
if [[ ! -d $TPM_DIRECTORY ]]; then
	git clone https://github.com/tmux-plugins/tpm $TPM_DIRECTORY 
fi

# Push files from '.dotfiles' folder to '~'
cd ~/.dotfiles

stow git
stow nvim
stow tmux
stow git

# Install Antigen plugins
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# Show hidden files in autocompletion
setopt globdots

# Run Tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s main
fi

cd ~
