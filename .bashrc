export EDITOR=vim
export PAGER=less
export BROWSER=chromium
export TERM=xterm

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# append to the history file, don't overwrite it
shopt -s histappend

# use case-insensitive filename globbing
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

eval $(dircolors ~/.dircolors)

unset SSH_ASKPASS

export PS1="\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[$(tput sgr0)\] \[\033[36;5;1m\]\$(git_branch)\[$(tput sgr0)\]$ "

export GOPATH=$HOME/go
export PATH=$PATH:"$GOPATH/bin":"$HOME/.composer/vendor/bin/":"$HOME/bin"
