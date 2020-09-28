# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="./.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    zsh-syntax-highlighting
    kube-ps1
    zsh-autosuggestions
    kubectl
    )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# enable the default zsh completions
autoload -Uz compinit && compinit

# My prompt so far
PROMPT='[%n@%F{green}%m%f %~] %# '

# SSH AGENT
eval `ssh-agent`
if [ "$(uname)" = "Darwin" ]; then
    ssh-add -K ~/.ssh/id_rsa       
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    ssh-add ~/.ssh/id_rsa
fi

# Change to a dir if it is on a line alone
setopt AUTO_CD

# History options
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# ZSH Corrections
setopt CORRECT
setopt CORRECT_ALL

autoload -Uz compinit && compinit

PATH="$HOME/.tfenv/bin:$PATH"
EDITOR=/usr/bin/vim

CLICOLOR=1
LSCOLORS=ExFxBxDxCxegedabagacad

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Docker runnnnn
alias dcrun="docker-compose -f /mnt/storage/docker-compose.yml"
alias dclogs='docker-compose -f /mnt/storage/docker-compose.yml logs -tf --tail="50" '

# Mac stuff
if [ "$(uname)" = "Darwin" ]; then
    alias f='open -a Finder ./'
    alias DT='tee ~/Desktop/terminalOut.txt'
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
    ql () { qlmanage -p "$*" >& /dev/null; }
    alias memHogsTop='top -l 1 -o rsize | head -20'
fi

alias ls='ls -GFh'
alias grep='grep --color=auto'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# if [ "$(uname)" = "Darwin" ]; then
#     # Do something under Mac OS X platform        
# elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
#     # Do something under GNU/Linux platform
# fi

alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias less='less -FSRXc'

alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'

alias fix_stty='stty sane'

alias numFiles='echo $(ls -1 | wc -l)'

alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

alias lsock='sudo /usr/sbin/lsof -i -P'
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'
alias openPorts='sudo lsof -i | grep LISTEN'
alias showBlocked='sudo ipfw list'

cd() { builtin cd "$@"; ll; }
mcd () { mkdir -p "$1" && cd "$1"; }

ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
}
