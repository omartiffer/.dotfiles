#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Installing Tmux..."
if_not_dry sudo apt install -y tmux

log INFO "Installing Tmux plugin manager..."
if_not_dry git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

log INFO "Installing Catppuccin theme..."
if_not_dry mkdir -p "$HOME/.tmux/plugins/catppuccin"
if_not_dry git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
  "$HOME/.tmux/plugins/catppuccin/tmux"

log INFO "Installing Tmuxinator..."
if_not_dry sudo apt install -y tmuxinator

log OK "Tmux installed successfully\n"
