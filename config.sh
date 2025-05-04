#!/usr/bin/env bash

source "$DOTFILES"/utils.sh

### Parse args ###
dry_run="false"

while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry-run" ]]; then
        dry_run="true"
    fi
    shift
done

copy_dir() {
    local from=$1
    local to=$2

    pushd "$from" &>/dev/null
    while IFS= read -r entry; do
        log INFO "Replacing $to/$entry with $PWD/$entry..."
        if_not_dry rm -rf "$to/$entry"
        if_not_dry cp -avr "$PWD/$entry" "$to/$entry"
    done < <(find . -mindepth 1 -maxdepth 1 \( -type f -o -type d \))
    popd &>/dev/null
}

copy_file() {
    local from=$1
    local to=$2

    log INFO "Replacing $to with $from"
    if_not_dry rm "$to"
    if_not_dry cp "$from" "$to"
}

copy_dir "$DOTFILES/.config" "$HOME/.config"
copy_dir "$DOTFILES/.oh-my-zsh" "$HOME/.oh-my-zsh"

copy_file "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
copy_file "$DOTFILES/.zshrc" "$HOME/.zshrc"
copy_file "$DOTFILES/config.sh" "$HOME/.local/bin/hydrate-conf"

if_not_dry chmod u+x "$HOME/.local/bin/hydrate-conf"
