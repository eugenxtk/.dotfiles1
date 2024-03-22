# .dotfiles

### Install

1. Install Git by your package manager (if it's not installed yet).
2. Execute: `cd ~ && rm -rf ~/.dotfiles && git clone https://github.com/eugenxtk/.dotfiles.git ~/.dotfiles && bash ~/.dotfiles/base.sh`.

### Remove

Use to remove: `cd ~ && sudo rm -rf /nix ~/.nix* ~/.local/state/nix ~/.antigen ~/antigen.zsh ~/.dotfiles ~/.zshrc && sudo apt-get remove -y zsh && sudo chsh -s $(which bash) "$USER"`.

### Update

Use `dotfiles-update` to update.
