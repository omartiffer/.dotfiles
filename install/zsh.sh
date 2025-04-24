#!/usr/bin/env bash

source "../utils/log.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Zsh ###
log INFO "Installing Zsh..."
if [[ "$dry_run" == "false" ]]; then
    sudo apt install -y zsh
    hash -r
    sudo chsh -s $(which zsh)
fi

### Install Oh My Zsh ###
log INFO "Installing Oh My Zsh..."
if [[ "$dry_run" == "false" ]]; then
    sh -c "$(curl -fsSL \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

### Install OMZ plugins ###
log INFO "Installing OMZ plugins..."
if [[ "$dry_run" == "false" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
fi

log OK "Zhs setup complete!\n"