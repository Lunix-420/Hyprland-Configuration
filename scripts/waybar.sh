#!/bin/sh

CONFIG="$HOME/.config/hypr/waybar/config"
STYLE="$HOME/.config/hypr/waybar/style.css"

killall waybar

waybar -c $CONFIG &
-s $STYLE
