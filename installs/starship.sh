#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Installing Starship shell prompt..."
if_not_dry curl -sS https://starship.rs/install.sh | sh -s -- -y

log OK "Starship installed successfully\n"
