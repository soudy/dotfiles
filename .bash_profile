[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(tty) = "/dev/tty1" ]] && startx
