# .bashrc
export EDITOR=vim
export TERMINAL=urxvt
export BROWSER=firefox
export PAGER="most"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# start with tmux
# [[ -z $TMUX  ]] && exec tmux

# Aliases
alias srecord="ffmpeg -f dshow -i -c:v libvpx -b:v 2M -deadline realtime -cpu-used -5 -threads %threads% -c:a libvorbis -y output.webm"
alias xip="curl icanhazip.com"
alias reload='source ~/.bashrc'
alias swpclear='find ./ -type f -name "\.*sw[klmnop]" -delete'
alias setssh='eval $(ssh-agent) && ssh-add'
alias se='sudoedit'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias grep='grep --color=auto'
alias poweroff='sudo poweroff'
alias mkdir='mkdir -pv'
alias ls='ls --color=always'
alias sl='ls'
alias l='ls'
alias ll='ls -Alh'
alias ticktock='watch -n1 "date '+%D%n%T'|figlet -k"'
alias df='df -H'
alias vi="vim"
alias sudo="sudo "
alias locip="ip addr show | grep -E 'inet' | grep -m 1 global | awk '{ print $2}' | sed 's/\/.*//'"
alias termbin="nc termbin.com 9999"
alias fuck="fux $(history | tail -n 2 | head -n 1 | awk '{print $2}')"
#export PS1="\[\e[00;36m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;35m\]\h\[\e[0m\]\[\e[00;37m\] [\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\]] \[\e[0m\]"
export PS1="\[\e[00;37m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;35m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\] $ \[\e[0m\]"

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

unset SSH_ASKPASS

export PATH=~/.gem/ruby/2.2.0/bin/:$PATH
