#!/usr/bin/env bash

log() {
    local NC='\033[0m'
    local OK='\033[0;32m'
    local ERR='\033[0;31m'
    local INFO='\033[0;34m'
    local WARN='\033[1;33m'

    local color_arg="${1}"
    local message="${2:-$1}"

    case "$color_arg" in
        NC|OK|ERR|INFO|WARN)
            local color="${!color_arg}" ;;
        *) local color=$NC ;;
    esac

    if [[ "$dry_run" == "true" ]]; then
        echo -e "${color}[DRY_RUN]: ${message}${NC}"
    else
	    echo -e "${color}${message}${NC}"
    fi
}