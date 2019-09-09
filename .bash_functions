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
        virtualenv --python=python3.5 ./env "$@"
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
    command git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
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

function gocd {
    cd ~/go/src/github.com/soudy/"$@"
}

function g {
    case $1 in
        push|pull|fetch)
            ssh-add -l | grep "The agent has no identities" && ssh-add -t 12h
            ;;
    esac

    command git "$@"
}

function setssh {
    if [[ "$1" == g ]]; then
        key=~/.ssh/google_compute_engine
    else
        key=~/.ssh/id_ed25519
    fi

    ssh-add -t 24h "$key"
}

function rmnone {
    docker rmi "$@" $(docker images | grep "^<none>" | awk '{print $3}')
}

function kns {
    if [ -z "$1" ]; then
        echo -e "Usage: kns [context] [namespace]\nExample: kns gke_old development"
    else
        kubectl config use-context "$1"
        kubectl config set-context "$1" --namespace="$2"
    fi
}

function rmdockershit {
    docker rmi $(docker images -aq --filter dangling=true)
    docker rm -v $(docker ps -a -q -f status=exited)
}

function gssh {
    local ip
    ip=$(gcloud compute instances list | grep "^$1\b" | awk '{print $(NF - 2)}')
    ssh "$USER@$ip"
}

function ssh_infra {
  ssh student@192.168.131.1 -p 22022
}

function i3_err {
  DISPLAY=:0 i3-dump-log
}

function reload-network-driver {
   sudo rmmod brcmfmac && sudo modprobe brcmfmac
}
