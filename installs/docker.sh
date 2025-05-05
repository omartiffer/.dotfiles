#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Add Docker's official GPG key..."
if_not_dry sudo apt-get update
if_not_dry sudo install -m 0755 -d /etc/apt/keyrings
if_not_dry sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
if_not_dry sudo chmod a+r /etc/apt/keyrings/docker.asc

log INFO "Add the repository to Apt sources..."
if_not_dry echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
if_not_dry sudo apt-get update

log INFO "Installing Docker..."
if_not_dry sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

log OK "Successfully installed Docker\n"
