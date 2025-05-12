#!/usr/bin/env bash

source "$DOTFILES/utils.sh"

parse_args "$@"

readonly EXDIR="$HOME"/.local/share/fonts/nerdfonts

font_urls=(
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CodeNewRoman.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/ComicShannsMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/VictorMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Ubuntu.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuMono.zip
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/UbuntuSans.zip
)

mkdir -p "$EXDIR"

for url in "${font_urls[@]}"; do
  file_name=$(echo "$url" | awk -F'/' '{print $9}')

  log INFO "Downloading $file_name..."
  if_not_dry wget "$url" -O /tmp/"$file_name"

  log INFO "Extracting and installing $file_name..."
  if_not_dry unzip -o "/tmp/$file_name" -d "$EXDIR" >/dev/null
done

fc-cache -fv

log OK "Nerd fonts installed successfully\n"
