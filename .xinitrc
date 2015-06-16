#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f ~/.Xresources  ] && xrdb -merge ~/.Xresources
[ -f /etc/xprofile  ] && . /etc/xprofile
[ -f ~/.xprofile  ] && . ~/.xprofile

xset r rate 220 65
xsetroot -cursor_name left_ptr

mpd &
nm-applet &
hsetroot -fill ~/Pictures/wallpapers/image_17.jpg &
sxhkd &
exec bspwm
# exec awesome
