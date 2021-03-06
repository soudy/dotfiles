#echo -n  $(amixer | if grep -q "off"; then echo -n "mute"; else echo -n $(amixer | awk '/Front Left: Playback/ {print $5}' | sed 's/\[//g;s/\]//g');fi)

#!/bin/bash
#
icon_mute=''
icon_full=''
icon_rest=''
icon_phones=''

volume=$(amixer sget Master | sed -n "0,/.*\[\([0-9]\+\)%\].*/s//\1/p")

icon=$icon_rest
muted=$(amixer -c 0 get Master | grep -o off)

if [ $volume -eq 0 ] || [ $muted ]; then
	icon=$icon_mute
elif [ $volume -gt 25 ]; then
	icon=$icon_full
fi

if [ $headphones -eq 1 ]; then
	phones=" "$icon_phones
else
	phones=""
fi

#printf "%s %3s%%%%" "$icon" "$volume"
echo "V %{F#FF608190}$icon%{F-} $volume%%{F#FF608190}$phones%{F-}%{A}"
