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
alias pscat="bat --paging=never --style=plain"

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

# Windows Terminal Gruvbox theme config
: '
	{
            "background": "#282828",
            "black": "#282828",
            "blue": "#458588",
            "brightBlack": "#928374",
            "brightBlue": "#83A598",
            "brightCyan": "#8EC07C",
            "brightGreen": "#B8BB26",
            "brightPurple": "#D3869B",
            "brightRed": "#FB4934",
            "brightWhite": "#EBDBB2",
            "brightYellow": "#FABD2F",
            "cursorColor": "#7C6F64",
            "cyan": "#689D6A",
            "foreground": "#FBF1C7",
            "green": "#98971A",
            "name": "Gruvbox Dark",
            "purple": "#B16286",
            "red": "#CC241D",
            "selectionBackground": "#7C6F64",
            "white": "#A89984",
            "yellow": "#D79921"
        },
'
