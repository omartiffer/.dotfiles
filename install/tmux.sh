#!/usr/bin/env bash

source "../utils/log.sh"

### Parse args ###

dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Tmux ###
log INFO "Installing Tmux..."
if [[ "$dry_run" == "false" ]]; then
    sudo apt install -y tmux
fi

### Install Tmux plugin manager ###
log INFO "Installing Tmux plugin manager..."
if [[ "$dry_run" == "false" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

### Install Catppuccin theme for Tmux ###
log INFO "Installing Catppuccin theme..."
if [[ "$dry_run" == "false" ]]; then
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
        ~/.config/tmux/plugins/catppuccin/tmux
fi

log OK "Tmux setup complete!\n"