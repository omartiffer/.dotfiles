#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
    dry_run="true"
fi

### Install Starship prompt ###
log INFO "Installing Starship shell prompt..."
if_not_dry curl -sS https://starship.rs/install.sh | sh

log OK "Ghostty setup complete!\n"
