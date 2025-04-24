#!/usr/bin/env bash

source "../utils/log.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install Ghostty dependency packages ###
log INFO "Installing Ghostty dependency packages..."
if [[ "$dry_run" == "false" ]]; then
    sudo apt install libgtk-4-dev libadwaita-1-dev git blueprint-compiler gettext libxml2-utils
fi

### Install Zig (required to build Ghostty) ###
log INFO "Downloading Zig to \$HOME/.local/opt and adding it to \$PATH..."

if [[ ! -d "$HOME/.local/opt" ]]; then
    mkdir -p "$HOME/.local/opt"
fi

if [[ "$dry_run" == "false" ]]; then
    wget https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz -O /tmp/zig.tar.xz
    tar -xvf /tmp/zig.tar.xz -C $HOME/.local/opt
    export PATH="$HOME/.local/opt/zig-linux-x86_64-0.14.0:$PATH"
fi

### Clone and build Ghostty ###
log INFO "Cloning Ghostty to \$HOME/.local/src/ghostty..."

if [[ ! -d "$HOME/.local/src" ]]; then
    mkdir -p "$HOME/.local/src"
fi

if [[ "$dry_run" == "false" ]]; then
    git clone https://github.com/ghostty-org/ghostty "\$HOME/.local/src/ghostty"
fi

log INFO "Building Ghostty..."
if [[ "$dry_run" == "false" ]]; then
    (
        cd $HOME/.local/src/ghostty
        zig build -p $HOME/.local -Doptimize=ReleaseFast
    )
fi

log OK "Ghostty setup complete!\n"