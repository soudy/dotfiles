export EDITOR=vim
export BROWSER=chromium
export PAGER=less

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# start with tmux
# [[ -z $TMUX  ]] && exec tmux

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# use case-insensitive filename globbing
shopt -s nocaseglob

eval $(dircolors ~/.dircolors)

unset SSH_ASKPASS

export PS1="\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[36;5;1m\]\$(git_branch)\[$(tput sgr0)\]$ "
export GOPATH=$HOME/tech/go
export PATH=$PATH:"$GOPATH/bin":/home/soud/.gem/ruby/2.2.0/bin:"$HOME/.composer/vendor/bin/"
