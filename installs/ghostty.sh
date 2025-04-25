#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Ghostty dependency packages ###
log INFO "Installing Ghostty dependency packages..."
if_not_dry sudo apt install -y libgtk-4-dev libadwaita-1-dev git blueprint-compiler gettext libxml2-utils

### Install Zig (required to build Ghostty) ###
log INFO "Downloading Zig to \$HOME/.local/opt and adding it to \$PATH..."
mkdir -p "$HOME/.local/opt"
if_not_dry wget https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz -O /tmp/zig.tar.xz
if_not_dry tar -xvf /tmp/zig.tar.xz -C "$HOME/.local/opt"
if_not_dry export PATH="$HOME/.local/opt/zig-linux-x86_64-0.14.0:$PATH"

### Clone and build Ghostty ###
log INFO "Cloning Ghostty to \$HOME/.local/src/ghostty..."
mkdir -p "$HOME/.local/src"
if_not_dry git clone https://github.com/ghostty-org/ghostty "$HOME/.local/src/ghostty"

log INFO "Building Ghostty..."
(
    if_not_dry cd "$HOME/.local/src/ghostty"
    if_not_dry zig build -p "$HOME/.local -Doptimize=ReleaseFast"
)

log OK "Ghostty setup complete!\n"