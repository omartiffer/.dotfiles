#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Installing Zsh..."
if_not_dry sudo apt install -y zsh
if_not_dry hash -r
if_not_dry sudo chsh -s "$(which zsh)"

log INFO "Installing Oh My Zsh..."
if_not_dry sh -c "$(curl -fsSL \
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

log INFO "Installing OMZ plugins..."
if_not_dry git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH"/custom/plugins/zsh-autosuggestions
if_not_dry git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH"/custom/plugins/zsh-syntax-highlighting
if_not_dry git clone https://github.com/MichaelAquilina/zsh-you-should-use.git \
  "$ZSH"/custom/plugins/you-should-use

if_not_dry omz reload

log OK "Zhs setup complete!\n"
