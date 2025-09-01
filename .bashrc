# Bash configuration for .NET development environment

# Enhanced history
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Better directory navigation
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s checkwinsize

# Colored output
export GREP_OPTIONS='--color=auto'
export LESS='-R'

# .NET environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export ASPNETCORE_ENVIRONMENT=Development

# Add dotnet tools to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.dotnet/tools:"* ]]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi

# Useful aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# System information
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

# Colored prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi