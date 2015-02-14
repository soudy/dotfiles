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
alias wmap='nmap -sP 192.168.1-255.1-255'
alias suspend='sudo pm-suspend'
alias hibernate='sudo pm-hibernate'
alias poweroff='sudo poweroff'
alias mkdir='mkdir -pv'
alias ls='ls --color=always'
alias sl='ls'
alias l='ls'
alias ll='ls -Alh'
alias ticktock='watch -n1 "date '+%D%n%T'|figlet -k"'
alias pcat='pygmentize -O style=native -g'
alias df='df -H'
alias merrychristmas='curl climagic\.org/txt/jb.txt|while read -r c n l;do printf "\e[1;${c}m%${COLUMNS}s\e[0m\n" " ";play -q -n synth pl $n trim 0 $l;done '
alias snow="xsnow -notrees -nosanta -norudolf -snowflakes 1000 -nokeepsnow"
alias vi="vim"
alias sudo="sudo "
alias dual="xrandr --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal             \
            --output VIRTUAL1 --off --output DP1 --off --output eDP1 --off --output VGA1 \
            --mode 1920x1080 --pos 1920x0 --rotate normal"

#enable and disable http firewall
alias httpe='sudo firewall-cmd --add-service=http'
alias httpr='sudo firewall-cmd --remove-service=http'

#export PS1="\[\e[00;36m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;35m\]\h\[\e[0m\]\[\e[00;37m\] [\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\]] \[\e[0m\]"
export PS1="\[\e[00;36m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;35m\]\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\] % \[\e[0m\]"


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
