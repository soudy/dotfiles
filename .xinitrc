#! /bin/sh

# . /etc/X11/Xsession

xset +fp /usr/share/fonts/local &
xset fp rehash &

xset r rate 220 65 &
xset m 3 1 &
xsetroot -cursor_name left_ptr &

export $(dbus-launch)

compton &
#eval `dbus-launch --auto-syntax` nm-applet &
nm-applet &
fluxgui &

xrandr --dpi 200
xrdb -merge ~/.Xresources

synclient HorizTwoFingerScroll=1
synclient RightButtonAreaLeft=3068
synclient RightButtonAreaRight=0
synclient RightButtonAreaTop=4326
synclient RightButtonAreaBottom=0
synclient MaxTapTime=0


export GDK_SCALE=2
export GDK_DPI_SCALE=.5

exec i3 --shmlog-size=26214400
# exec awesome
