#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

snaps=(
  brave
  discord
  multipass
  postman
  scc
  slack
  spotify
  firefox
)

for snap in "${snaps[@]}"; do
  if snap list | awk '{print $1}' | grep -qx "$snap"; then
    log INFO "$snap is already installed. Skipping..."
  else
    log INFO "Installing $snap..."
    if_not_dry sudo snap install "$snap"
  fi
done

snaps_classic=(
  alacritty
  aws-cli
  code
  ghostty
  goland
  pycharm-community
  intellij-idea-community
)

for snap in "${snaps_classic[@]}"; do
  if snap list | awk '{print $1}' | grep -qx "$snap"; then
    log INFO "$snap is already installed. Skipping..."
  else
    log INFO "Installing $snap..."
    if_not_dry sudo snap install "$snap" --classic
  fi
done

log OK "Common apps installed successfully\n"
