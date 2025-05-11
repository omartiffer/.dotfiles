#!/usr/bin/env bash

# Copyright 2025 Omar Tiffer
#
# Portions of this file are based on code from ThePrimeagen’s
# "My Dev Setup Is Better Than Yours" course on Frontend Masters.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

source "$DOTFILES"/utils.sh

parse_args "$@"

log INFO "Installing required packages..."
if_not_dry sudo apt-get update
if_not_dry sudo apt-get install -y git unzip curl jq fzf ripgrep wget yq gcc ca-certificates

if [[ -n $filter ]]; then
  log INFO "Running with filter=$filter..."
fi

while IFS= read -r script; do
  if echo "$script" | grep -qv "$filter"; then
    log PLAIN "Filtered: $script"
    continue
  fi

  log WARN "Running: $script..."
  if [[ $dry_run == "true" ]]; then
    "$script" --dry-run
  else
    "$script"
  fi
done < <(find "$DOTFILES"/installs -maxdepth 1 -mindepth 1 -type f)

log OK "Installation complete\n"
