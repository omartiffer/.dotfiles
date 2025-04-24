#!/usr/bin/env bash

source "$DOTFILES/utils/log.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Starship prompt ###
log INFO "Installing Starship shell prompt..."
if [[ "$dry_run" == "false" ]]; then
    curl -sS https://starship.rs/install.sh | sh
fi

log OK "Ghostty setup complete!\n"