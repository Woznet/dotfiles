# Zsh configuration for .NET development environment

# History configuration
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
unsetopt FLOW_CONTROL
unsetopt MENU_COMPLETE

# .NET environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export ASPNETCORE_ENVIRONMENT=Development

# Add dotnet tools to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.dotnet/tools:"* ]]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi

# Colored output
export GREP_OPTIONS='--color=auto'
export LESS='-R'

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# .NET aliases
alias dnb='dotnet build'
alias dnr='dotnet run'
alias dnt='dotnet test'
alias dnc='dotnet clean'
alias dnp='dotnet publish'
alias dnw='dotnet watch'
alias dnrs='dotnet restore'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Directory shortcuts
alias cdw='cd /workspaces'
alias cdp='cd ~/projects'

# System aliases
alias ports='netstat -tuln'
alias myip='curl -s https://ifconfig.me'

# Functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract function
extract() {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Simple prompt (will be enhanced if oh-my-zsh is installed)
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '