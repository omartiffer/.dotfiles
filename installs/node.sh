#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Downloading and installing nvm..."
if_not_dry curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

if_not_dry \. "$HOME/.nvm/nvm.sh"

log INFO "Downloading and installing Node.js..."
if_not_dry nvm install --lts

log INFO "Installed Node.js version:"
if_not_dry node -v
log INFO "Installed NVM version:"
if_not_dry nvm current
log INFO "Installed NPM version:"
if_not_dry npm -v

log OK "Node.js installed successfully\n"
