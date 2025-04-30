#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Zsh ###
log INFO "Installing Zsh..."
if_not_dry sudo apt install -y zsh
if_not_dry hash -r
if_not_dry sudo chsh -s "$(which zsh)"

### Install Oh My Zsh ###
log INFO "Installing Oh My Zsh..."
if_not_dry sh -c "$(curl -fsSL \
	https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Install OMZ plugins ###
log INFO "Installing OMZ plugins..."
if_not_dry git clone https://github.com/zsh-users/zsh-autosuggestions \
	"${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if_not_dry git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	"${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if_not_dry git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
	"${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use"

log OK "Zhs setup complete!\n"
