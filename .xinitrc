#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xset +fp /usr/share/fonts/local
xset fp rehash

xset r rate 220 65 &
xsetroot -cursor_name left_ptr &

dunst &
compton &
mpd &
nm-applet &
# hsetroot -center ~/Pictures/coldflow.jpg &
# hsetroot -tile ~/Pictures/pattern_154.gif &
hsetroot -fill ~/Pictures/wallpapers/image_134.jpg &
sxhkd -f 100 &

exec bspwm
# exec awesome
