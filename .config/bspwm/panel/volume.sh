#echo -n  $(amixer | if grep -q "off"; then echo -n "mute"; else echo -n $(amixer | awk '/Front Left: Playback/ {print $5}' | sed 's/\[//g;s/\]//g');fi)

#!/bin/bash
#
icon_mute=''
icon_full=''
icon_rest=''
icon_phones=''

volume=$(amixer sget Master | sed -n "0,/.*\[\([0-9]\+\)%\].*/s//\1/p")

icon=$icon_rest

if [ $volume -eq 0 ]; then
	icon=$icon_mute
elif [ $volume -gt 25 ]; then
	icon=$icon_full
fi

headphones=$(cat ~/.phones)

if [ $headphones -eq 1 ]; then
	phones=" "$icon_phones
else
	phones=""
fi

#printf "%s %3s%%%%" "$icon" "$volume"
echo "V %{F#FF66AABB}$icon%{F-} $volume%%{F#FF66AABB}$phones%{F-}%{A}"
