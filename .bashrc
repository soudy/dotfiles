export EDITOR=vim
export PAGER=less
export BROWSER=firefox
export TERM=xterm-256color
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
export PS1="\u:\[$(tput sgr0)\]\[\033[38;5;1m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[$(tput sgr0)\] \[\033[36;5;1m\]\$(git_branch)\[$(tput sgr0)\]$ "
export GOPATH=$HOME/go
export PATH=$PATH:"$GOPATH/bin":"$HOME/.composer/vendor/bin/":"$HOME/bin":"$(ruby -rubygems -e 'puts Gem.user_dir')/bin"
export GPGKEY=90F51EE4
export DOTNET_CLI_TELEMETRY_OPTOUT=1

. /etc/bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

unset HISTSIZE
export HISTSIZE
unset HISTFILESIZE
export HISTFILESIZE

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

set -o emacs

# added by travis gem
[ -f /home/soud/.travis/travis.sh ] && source /home/soud/.travis/travis.sh

[[ -s /home/soud/.autojump/etc/profile.d/autojump.sh ]] && source /home/soud/.autojump/etc/profile.d/autojump.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/.dotnet/tools/"
[[ -d "/usr/lib/go-1.11" ]] && export PATH="$PATH:/usr/lib/go-1.11/bin"

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/soud/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/soud/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/soud/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/soud/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

export $(dbus-launch)
