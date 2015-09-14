IFS=@
icon_charge='%{F#FFFEA63C}%{F-}'
icon_max='%{F#FF66AABB}%{F-}'
icon_full='%{F#FF66AABB}%{F-}'
icon_rest='%{F#FF66AABB}%{F-}'
icon_dead='%{F#FF66AABB}%{F-}'
#acpinfo=$(acpi -a)
#

chg(){
    echo -n  $(acpi --battery | awk '{gsub(/,/, "");} {print $4}')
}

chg_per=$(acpi --battery | awk '{gsub(/,/, "");} {print $4}' | sed 's/.$//')
#[chg_per='0'

if [ $chg_per -lt 33 ]; then
	icon=$icon_dead
elif [ $chg_per -lt 67 ]; then
	icon=$icon_rest
elif [ $chg_per -gt 66 ]; then
	icon=$icon_full
fi

if acpi -a | grep -q "on-line"; then
	#echo -n "⮒ $(chg)%"
	icon=$icon_charge
	if [ $chg_per -gt 95 ]; then
		icon=$icon_max
	fi
fi

#echo B%{A:"~/.config/bspwm/panel/menus/battery-menu.sh test":}$(acpi -a | if grep -q "on-line"; then echo -n "⮒ $(chg)%"; else echo -n "$icon $(chg)%"; fi)%{A}
#echo B$(acpi -a | if grep -q "on-line"; then echo -n "⮒ $(chg)%"; else echo -n "$icon $(chg)%"; fi)%{A}

echo "B$icon $(chg)"
