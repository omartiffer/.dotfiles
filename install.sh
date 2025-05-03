#!/usr/bin/env bash

set -euo pipefail
trap 'echo -e "\nError on line $LINENO: $BASH_COMMAND"' ERR

export DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DOTFILES"/utils.sh

readarray -t scripts < <(find "$DOTFILES"/installs -maxdepth 1 -mindepth 1 -type f)

### Parse args ###
filter=""
dry_run="false"

while [[ $# -gt 0 ]]; do
    if [[ "$1" == "--dry-run" ]]; then
        dry_run="true"
    else
        filter="$1"
    fi
    shift
done

log INFO "Running with filter=$filter..."

for script in "${scripts[@]}"; do
    if echo "$script" | grep -qv "$filter"; then
        log PLAIN "Filtered: $filter -- $script"
        continue
    fi
    log WARN "Running script: $script..."

    if [[ $dry_run == "true" ]]; then
        bash "$script" --dry-run
    else
        bash "$script"
    fi
done
