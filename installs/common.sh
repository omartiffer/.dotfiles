#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Installing common packages..."
if_not_dry sudo apt install -y git unzip curl jq wget fzf install klavaro

snaps=(
    brave
    discord
    firefox
    ksnip
    ktouch
    lxd
    multipass
    postman
    scc
    slack
    spotify
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
    aws-cli
    code
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

log OK "Successfully installed common apps\n"
