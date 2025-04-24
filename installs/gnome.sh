#!/usr/bin/env bash

set -euo pipefail
trap 'echo -e "\nError on line $LINENO: $BASH_COMMAND"' ERR

### Globals ###
readonly EXT_LIST="$DOTFILES/gnome-files/gnome-extensions-list.txt"
readonly EXT_DIS="$DOTFILES/gnome-files/gnome-extensions-disable.txt"
readonly GNOME_EXT_URL="https://extensions.gnome.org/extension-query"
readonly EXT_INSTALLER_REPO="https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"

source "$DOTFILES/utils.sh"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Make sure required commands are present  ###
for cmd in curl jq wget; do
	command -v "$cmd" >/dev/null || { log ERR "$cmd is required but not installed."; exit 1; }
done

### Make sure required files are present ###
[[ -f "$EXT_LIST" ]] || { log ERR "Missing extension list: .dotfiles/gnome-files/"; exit 1; }
[[ -f "$EXT_DIS" ]] || { log ERR "Missing disable list: $EXT_DIS"; exit 1; }

main() {
	### Install prerequisites ###
	log INFO "Installing required packages..."
	if_not_dry sudo apt install -y gnome-browser-connector \
			gnome-shell-extension-prefs gnome-shell-extension-manager

	### Ensure necessary directories exist ###
	mkdir -p "$HOME/.local/share/gnome-shell/extensions"
	mkdir -p "$HOME/.local/bin"

	### Get Gnome extension installer ###
	log INFO "Downloading gnome-shell-extension-installer..."
	if [[ "$dry_run" == "false" ]]; then
		if wget -q -O "$DOTFILES/installs/gnome-shell-extension-installer" "$EXT_INSTALLER_REPO" 2> /dev/null; then
			log PLAIN "Download successful, installing..."
			install -m 755 "$DOTFILES/installs/gnome-shell-extension-installer" "$HOME/.local/bin/"
		else
			log WARN "Download failed, trying fallback..."
			if [[ -f "$DOTFILES/gnome-files/gnome-shell-extension-installer" ]]; then
				install -m 755 "$DOTFILES/gnome-files/gnome-shell-extension-installer" "$HOME/.local/bin/"
			else
				log ERR "Fallback installer not found in $DOTFILES/gnome-files"
				exit 1
			fi
		fi
	fi

	### Install Gnome extensions ###
	log INFO "Installing GNOME extensions from $EXT_LIST..."

	lineno=0
	while IFS= read -r e_uuid; do
		((++lineno))
		[[ -z "$e_uuid" ]] && continue

		log PLAIN "[$lineno] Looking up: $e_uuid"
		e_name=$(echo "$e_uuid" | awk -F'@' '{print $1}')
		e_pk=$(curl -s "$GNOME_EXT_URL/?search=$e_name" \
			| jq --arg uuid "$e_uuid" '.extensions[] | select(.uuid == $uuid) | .pk')

		if [[ -n "$e_pk" ]]; then
				log PLAIN "[$lineno] Found: $e_uuid (PK: $e_pk) - Installing..."
				if_not_dry gnome-shell-extension-installer --yes "$e_pk"
			else
				log WARN "[$lineno] Extension not found: $e_uuid"
			fi
	done < "$EXT_LIST"

	### These will be available but disabled ###
	log INFO "The following extensions will be initially disabled..."
	while IFS= read -r ext; do
		[[ -z "$ext" ]] && continue

		log PLAIN "Disabling: $ext"
		if_not_dry gnome-extensions disable "$ext" 2>/dev/null || log ERR "Could not disable $ext"
	done < "$EXT_DIS"

	### Final configuration ###
	log INFO "Restoring background images..."
	if_not_dry find "$DOTFILES/gnome-files/backgrounds" -type f -exec cp -av {} "$HOME/.local/share/backgrounds/" \;

	log INFO "Loading Gnome dconf file..."
	if_not_dry dconf load /org/gnome/ < "$DOTFILES/gnome-files/gnome.dconf"

	log OK "GNOME setup complete!\n"
}

main "$@"
