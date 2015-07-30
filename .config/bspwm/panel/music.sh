#!/bin/bash

# title=$(playerctl metadata title)
# artist=$(playerctl metadata artist)
# # ⮓ ⮔
# status=$(playerctl status)

# if [ $status = "Playing" ]; then
# 	staticon="⮓"
# else
# 	staticon="⮔"
# fi

cursong=$(mpc current)

zscroll -n -b "H%{A:urxvt -e 'ncmpcpp':}| ⮕ " "$(mpc current) " -a "%{A}"

