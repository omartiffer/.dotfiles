#--------------------------------------------------------
# Usage: parse_args "$@"
# Reads all arguments passed and assings 'dry_run' and
# 'filter' variables no matter the order. If you pass
# multiple filter arguments, it will take the last one.
#--------------------------------------------------------
parse_args() {
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
}

#--------------------------------------------------------
# Usage: if_not_dry COMMAND
# Executes the COMMAND if --dry-run is not passed as an
# argument to the calling script.
#--------------------------------------------------------
if_not_dry() {
    if [[ "$dry_run" == "false" ]]; then
        "$@"
    else
        log PLAIN "[DRY_RUN] Would run $*" >&2
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
    PLAIN | OK | ERR | INFO | WARN)
        local color="${!color_arg}"
        ;;
    *)
        local color=$PLAIN
        ;;
    esac

    echo -e "${color}${message}${PLAIN}"
}
