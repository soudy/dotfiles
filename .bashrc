export EDITOR=vim
export PAGER=less
export BROWSER=chromium
export TERM=xterm-256color

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

unset SSH_ASKPASS

eval $(dircolors ~/.dircolors)

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

export PS1="\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[$(tput sgr0)\] \[\033[36;5;1m\]\$(git_branch)\[$(tput sgr0)\]$ "

export GOPATH=$HOME/go
export PATH=$PATH:"$GOPATH/bin":"$HOME/.composer/vendor/bin/":"$HOME/bin":"$(ruby -rubygems -e 'puts Gem.user_dir')/bin"

[[ $DISPLAY ]] && ssh-add -l | grep "The agent has no identities" && ssh-add -t 8h
