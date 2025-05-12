#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Uninstall all conflicting packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  if_not_dry sudo apt-get -y remove "$pkg"
done

log INFO "Add Docker's official GPG key..."
if_not_dry sudo apt-get update
if_not_dry sudo install -m 0755 -d /etc/apt/keyrings
if_not_dry sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
if_not_dry sudo chmod a+r /etc/apt/keyrings/docker.asc

log INFO "Add the repository to Apt sources..."
if_not_dry echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
if_not_dry sudo apt-get update

log INFO "Installing Docker..."
if_not_dry sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

log INFO "Adding user '$USER' to the docker group..."
if_not_dry sudo usermod -aG docker "$USER"
if_not_dry newgrp docker

log OK "Docker installed successfully\n"
