# export TERM="xterm-256color"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="avit" # set by `omz`

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z fzf zsh-autosuggestions you-should-use zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
alias ll="ls -lhS --group-directories-first"
alias vim="nvim"
alias tx="tmuxinator"

# ENVs
export EDITOR='nvim'

# Add to PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/my-scripts
export PATH=/snap/aws-cli/1429/bin/:$PATH

# Keymaps
bindkey -s ^f "tmux-sessionizer\n"

# Initialize Starship
eval "$(starship init zsh)"

# Enable shell completions for Alacritty
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Enable shell integration for fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)

zstyle ':completion:*' menu select

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aws-cli command completions
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/snap/aws-cli/1429/bin/aws_completer' aws
