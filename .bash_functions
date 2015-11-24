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
        virtualenv --no-site-packages ./env
    else
        . env/bin/activate
    fi
}
