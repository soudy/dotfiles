alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias http='python -m http.server'
alias xip='curl icanhazip.com'
alias reload='source ~/.bashrc'
alias setssh='eval $(ssh-agent) && ssh-add'
alias se='sudoedit'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias grep='grep --color=auto'
alias poweroff='sudo poweroff'
alias fan='sudo resume'
alias arp='sudo arp-scan --localnet'
alias hib='systemctl hibernate'
alias susp='systemctl suspend'
alias mkdir='mkdir -pv'
alias ls='ls --color=always -F'
alias sl='ls'
alias l='ls'
alias ll='ls -Alh'
alias df='df -H'
alias vi='vim'
alias sudo='sudo '
alias locip="ip addr show | grep -E 'inet' | grep -m 1 global | cut -d\  -f6"
