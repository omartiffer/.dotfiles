
#--------------------------------------------------------
# Usage: if_not_dry COMMAND
# Executes the COMMAND if --dry-run is not passed as an
# argument to the calling script.
#--------------------------------------------------------
if_not_dry() {
	if [[ "$dry_run" == "false" ]]; then
	    "$@"
	else
       	log PLAIN "Would run $*"
	fi
}

#--------------------------------------------------------
# Usage: log [LEVEL] MESSAGE
# If [LEVEL] is omitted, the argument you pass becomes the
# message and is printed with [PLAIN] (no formatting).
# Example: log "This will print unformatted"
#--------------------------------------------------------
log() {
	local PLAIN='\033[0m'
   	local OK='\033[0;32m'
   	local ERR='\033[0;31m'
   	local INFO='\033[0;34m'
   	local WARN='\033[1;33m'

   	local color_arg="${1}"
   	local message="${2:-$1}"

   	case "$color_arg" in
		PLAIN|OK|ERR|INFO|WARN)
			local color="${!color_arg}" ;;
       	*)
            local color=$PLAIN ;;
	esac

    if [[ "$dry_run" == "true" ]]; then
       	echo -e "${color}[DRY_RUN]: ${message}${PLAIN}"
    else
		echo -e "${color}${message}${PLAIN}"
	fi
}
