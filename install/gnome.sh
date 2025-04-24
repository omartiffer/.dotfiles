#!/usr/bin/env bash

set -euo pipefail
trap 'echo -e "\nError on line $LINENO: $BASH_COMMAND"' ERR

source "$DOTFILES/utils/log.sh"

### Globals ###

readonly EXT_LIST="./gnome-files/gnome-extensions-list.txt"
readonly EXT_DIS="./gnome-files/gnome-extensions-disable.txt"
readonly GNOME_EXT_URL="https://extensions.gnome.org/extension-query"
readonly EXT_INSTALLER_REPO="https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"

### Parse args ###
dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
fi

### Install prerequisites ###
log INFO "Installing required packages..."
if [[ "$dry_run" == "false" ]]; then
	sudo apt install -y gnome-browser-connector \
		gnome-shell-extension-prefs gnome-shell-extension-manager
fi

### Ensure necessary directories exist ###
if [[ ! -d "$HOME/.local/share/gnome-shell/extensions" ]]; then
	mkdir -p "$HOME/.local/share/gnome-shell/extensions"
fi

if [[ ! -d "$HOME/.local/bin" ]]; then
	mkdir -p "$HOME/.local/bin"
fi

### Get Gnome extension installer ###
log INFO "Downloading gnome-shell-extension-installer..."
if [[ "$dry_run" == "false" ]]; then
	wget -O gnome-shell-extension-installer \
		"$EXT_INSTALLER_REPO" \
		|| { log ERR "Failed to download gnome-shell-extension-installer\n"; exit 1; }

	chmod +x gnome-shell-extension-installer
	mv gnome-shell-extension-installer "$HOME/.local/bin/"
fi

### Install Gnome extensions ###
log INFO "Installing GNOME extensions from $EXT_LIST..."

lineno=0
while IFS= read -r e_uuid; do
	((++lineno))
	[[ -z "$e_uuid" ]] && continue

	log "[$lineno] Looking up: $e_uuid"
	e_name=$(echo "$e_uuid" | awk -F'@' '{print $1}')
	e_pk=$(curl -s "$GNOME_EXT_URL/?search=$e_name" \
    	| jq --arg uuid "$e_uuid" '.extensions[] | select(.uuid == $uuid) | .pk')

	if [[ -n "$e_pk" ]]; then
       		log "[$lineno] Found: $e_uuid (PK: $e_pk) - Installing..."

        	if [[ "$dry_run" == "false" ]]; then
            		gnome-shell-extension-installer --yes "$e_pk"
        	fi 
    	else
       		log "[$lineno] Extension not found: $e_uuid"
    	fi
done < "$EXT_LIST"

### These will be available but disabled ###
log INFO "These extensions will be disabled initially..."
while IFS= read -r ext; do
	[[ -z "$ext" ]] && continue

	log "Disabling: $ext"
    	if [[ "$dry_run" == "false" ]]; then
    		gnome-extensions disable "$ext" 2>/dev/null || echo -e "${ERR}\nCould not disable $ext"
    	fi
done < "$EXT_DIS"

### Final configuration ###
log INFO "Restoring background images..."
if [[ "$dry_run" == "false" ]]; then
	cp -av "$DOTFILES/install/gnome-files/backgrounds/*" "$HOME/.local/share/backgrounds/"
fi

log INFO "Loading Gnome dconf file..."
if [[ "$dry_run" == "false" ]]; then
	dconf load /org/gnome/ < "$DOTFILES/install/gnome-files/gnome.dconf"
fi

log OK "GNOME setup complete!\n"
