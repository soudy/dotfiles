[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
/usr/bin/xscreensaver -no-splash &
exec awesome --no-argb
