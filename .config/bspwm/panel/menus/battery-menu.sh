#!/bin/bash

# how long should the popup remain?
duration=20

# define geometry
barx=1120
bary=24
barw=160
barh=20

# colors
bar_bg='#ff333333'
bar_fg='#ffffffff' # white is default

# font used
bar_font='-*-uushi-medium-r-*--*-90-*-*-*-*-*-*'

# compute all this
baropt="-g ${barw}x${barh}+${barx}+${bary} -B${bar_bg} -f ${bar_font}"

# check if menu exists, kill if it does, create if it doesnt

if [ "$showing" == "true" ] 
then
	#pkill battery-menu.sh &
	echo lolwait

else
	showing=true
	echo " test$@" | bar-aint-recursive ${baropt}
	wait
fi
trap "echo Booh!" SIGINT SIGTERM
