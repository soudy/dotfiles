export EDITOR=vim
export PAGER=less
export BROWSER=firefox
export TERM=xterm-256color
export HISTSIZE=32768
export HISTFILESIZE="${HISTSIZE}"
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
export PS1="\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[$(tput sgr0)\] \[\033[36;5;1m\]\$(git_branch)\[$(tput sgr0)\]$ "
export GOPATH=$HOME/go
export PATH=$PATH:"$GOPATH/bin":"$HOME/.composer/vendor/bin/":"$HOME/bin":"$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
export GPGKEY=90F51EE4

. /etc/bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# Append to the history file, don't overwrite it
shopt -s histappend

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

unset SSH_ASKPASS

# eval $(dircolors ~/.dircolors)

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval $(ssh-agent)
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

GPG_TTY=$(tty)
export GPG_TTY

# added by travis gem
[ -f /home/soud/.travis/travis.sh ] && source /home/soud/.travis/travis.sh

[[ -s /home/soud/.autojump/etc/profile.d/autojump.sh ]] && source /home/soud/.autojump/etc/profile.d/autojump.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
