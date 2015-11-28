export EDITOR=vim
export BROWSER=firefox
export PAGER=less

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# start with tmux
# [[ -z $TMUX  ]] && exec tmux

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

export PS1="[\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\\$ \[$(tput sgr0)\]"

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Use case-insensitive filename globbing
shopt -s nocaseglob

eval $(dircolors ~/.dircolors)

unset SSH_ASKPASS

export GOPATH=$HOME/tech/go
export PATH=$PATH:$GOPATH/bin:/home/soud/.gem/ruby/2.2.0/bin
