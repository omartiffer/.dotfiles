#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Downloading Go binaries..."
if_not_dry wget https://go.dev/dl/go1.24.2.linux-amd64.tar.gz -O /tmp/go1.24.2.linux-amd64.tar.gz

log INFO "Removing previous installations..."
if_not_dry sudo rm -rf /usr/local/go
log INFO "Installing new binaries..."
if_not_dry sudo tar -C /usr/local -xzf /tmp/go1.24.2.linux-amd64.tar.gz >/dev/null
if_not_dry export PATH="$PATH":/usr/local/go/bin

log OK "Successfully installed $(go version)\n"
