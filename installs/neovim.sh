#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

log INFO "Installing dependencies..."
if_not_dry sudo apt install -y lua5.1 liblua5.1-0 liblua5.1-dev build-essential libreadline-dev

log INFO "Installing Telescope dependencies..."
if_not_dry sudo apt install -y fd-find ripgrep

log INFO "Installing LuaRocks..."
if_not_dry wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz -O /tmp/luarocks-3.11.1.tar.gz
if_not_dry tar zxpf /tmp/luarocks-3.11.1.tar.gz -C "$HOME/.local/src"
(
    if_not_dry cd "$HOME/.local/src/luarocks-3.11.1"
    if_not_dry ./configure --with-lua-include=/usr/include
    if_not_dry make
    if_not_dry sudo make install
)

log INFO "Installing Neovim..."
if_not_dry sudo snap install --classic nvim

log OK "Neovim setup complete!\n"
