function ix {
    local OPTIND
    local OPTS
    [[ -r "$HOME/.netrc" ]] && OPTS='-n'
    while getopts ":hd:l:i:n:" x; do
        case $x in
            d) $echo curl $OPTS -X DELETE ix.io/$OPTARG;
               return ;;
            l) curl -s http://ix.io/user/$OPTARG | \
               grep -Po "\<a href=\"\/[a-zA-Z]*\"\>" | \
               sed 's/<a href=\"/http:\/\/ix.io/g;s/\">//g'
               return ;;
            i) OPTS="$OPTS -X PUT";
               local id="$OPTARG" ;;
            n) OPTS="$OPTS -F read:1=$OPTARG" ;;
        esac
    done
    shift $(($OPTIND - 1))
    [[ -t 0 ]] && {
        local filename="$1"
        shift
        [[ "$filename" ]] && {
            curl $OPTS -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $OPTS -F f:1='<-' $* ix.io/$id
}

function venv {
    if [[ ! -d ./env ]]; then
        virtualenv ./env "$@"
    else
        . env/bin/activate "$@"
    fi
}

function man {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;31m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

function git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function n {
    nautilus . &> /dev/null &
    disown
}

function tunnel {
    sshuttle -r "$1" 0/0 -vv
}

function tunnel_dns {
    sshuttle --dns -r "$1" 0/0 -vv
}

function play {
    youtube-dl ytsearch:"$@" -q \
        --ignore-config \
        --console-title \
        --print-traffic \
        --max-downloads 1 \
        --no-call-home \
        --no-playlist -o - | mpv --no-terminal --force-window --cache=256 -
}

function g {
    cd ~/go/src/github.com/soudy/"$@"
}
