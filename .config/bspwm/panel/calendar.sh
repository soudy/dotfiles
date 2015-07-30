#!/bin/bash

pkill -x dmenu

if [ $(pgrep -cf stalonetray) -gt 0 ]; then
	if [ "$(xdotool search --onlyvisible --class stalonetray)" != "" ]; then
		xdotool search --class stalonetray 
		xdotool search --class stalonetray %@
		xdotool search --class stalonetray windowraise
	fi
else
	xdotool search --class stalonetray
	stalonetray
fi