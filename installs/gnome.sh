#!/usr/bin/env bash

set -euo pipefail
trap 'echo -e "\nError on line $LINENO: $BASH_COMMAND"' ERR

### Globals ###

readonly NC='\033[0m'
readonly OK='\033[0;32m'
readonly ERR='\033[0;31m'
readonly INFO='\033[0;34m'
readonly WARNING='\033[1;33m'
readonly EXT_LIST="./gnome-files/gnome-extensions-list.txt"
readonly EXT_DIS="./gnome-files/gnome-extensions-disable.txt"
readonly GNOME_EXT_URL="https://extensions.gnome.org/extension-query"
readonly EXT_INSTALLER_REPO="https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"

log() {
	if [[ "$dry_run" == "true" ]]; then
		echo -e "[DRY_RUN]: $1"
	else
		echo -e "$1"
	fi
}

### Parse args ###

dry_run="false"

if [[ "${1:-}" == "--dry-run" ]]; then
	dry_run="true"
    	echo -e "${WARNING}\nRunning in dry-run mode...\n${NC}"
fi

### Install prerequisites ###

echo -e "${INFO}Installing required packages...\n${NC}"

prereqs=(
	gnome-browser-connector
	gnome-shell-extension-prefs
	gnome-shell-extension-manager
	curl
	wget
	jq
)

log "Running apt update"
if [[ "$dry_run" == "false" ]]; then
	sudo apt update
fi

for p in "${prereqs[@]}"; do
	log "Installing package $p"
	if [[ "$dry_run" == "false" ]]; then
		sudo apt install -y "$p"
	fi
done
    

### Ensure necessary directories exist ###

if [[ ! -d "$HOME/.local/share/gnome-shell/extensions" ]]; then
	mkdir -p "$HOME/.local/share/gnome-shell/extensions"
fi

if [[ ! -d "$HOME/.local/bin" ]]; then
	mkdir -p "$HOME/.local/bin"
fi

### Get Gnome extension installer ###

echo -e "${INFO}\nDownloading gnome-shell-extension-installer...\n${NC}"
if [[ "$dry_run" == "false" ]]; then
	wget -O gnome-shell-extension-installer \
		"$EXT_INSTALLER_REPO" \
		|| { log "${ERR}\nFailed to download gnome-shell-extension-installer\n"; exit 1; }

	chmod +x gnome-shell-extension-installer
	mv gnome-shell-extension-installer "$HOME/.local/bin/"
fi

### Install Gnome extensions ###

echo -e "\n${INFO}Installing GNOME extensions from $EXT_LIST...\n${NC}"

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

echo -e "\n${INFO}These extensions will be disabled initially...\n${NC}"

while IFS= read -r ext; do
	[[ -z "$ext" ]] && continue

	log "Disabling: $ext"
    	if [[ "$dry_run" == "false" ]]; then
    		gnome-extensions disable "$ext" 2>/dev/null || echo -e "${ERR}\nCould not disable $ext"
    	fi
done < "$EXT_DIS"

### Final configuration ###

echo -e "\n${INFO}Restoring background images...\n${NC}"
if [[ "$dry_run" == "false" ]]; then
	cp -av "./gnome-files/backgrounds/*" "$HOME/.local/share/backgrounds/"
fi

echo -e "\n${INFO}Loading dconf file...\n${NC}"
if [[ "$dry_run" == "false" ]]; then
	dconf load /org/gnome/ < "./gnome-files/gnome.dconf"
fi

echo -e "${OK}GNOME setup complete!${NC}"
