#!/bin/bash


# WIFI ICONS
#

WIFISTATUS=$(cat /sys/class/net/wlp*/operstate)
QUAL=`iwconfig | grep 'Link Quality=' | awk '{gsub(/[=/]/," "); print $3}'`
MAX=`iwconfig | grep 'Link Quality=' | awk '{gsub(/[=/]/," "); print $4}'`

IP=$(ip addr | grep inet | grep -v inet6 | grep -v 127.0.0.1 | grep -v 192.168.122.1 | awk '{print $2}' | xargs echo -n)
#ifconfig wlp3s0b1 | grep inet | grep -v inet6 | awk '{print $2}'
ETHSTATUS=$(cat /sys/class/net/enp*/operstate)

icon=""

if [ "$WIFISTATUS" == "up" ]
then
	IP=$(iwconfig | grep ESSID | sed -e 's/.*ESSID:"\(.*\)".*/\1/')
	PERC=`echo $QUAL*100/$MAX | bc`
	case $PERC in
		[0-4])
			icon=""
		;;
		[4-9])
			icon=""
		;;
		[2-3]*)
			icon=""
		;;
		[4-5]*)
			icon=""
		;;
		[6-7]*)
			icon=""
		;;
		*)
			icon=""
		;;
esac
fi

if [ "$ETHSTATUS" == "up" ]
then
	icon=""
fi

if [ "$ETHSTATUS" == "down" ] && [ "$WIFISTATUS" == "down" ]
then
	icon=""
fi

echo "N%{F#FF608190}$icon%{F-}"
