#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/waybar/config"
STYLE="$HOME/.config/hypr/waybar/style.css"

is_running() {
	pgrep -x "waybar" >/dev/null
}

toggle() {
	if is_running; then
		echo "Hiding Waybar"
		killall -SIGUSR1 waybar
	else
		echo "Showing Waybar"
		waybar -c "$CONFIG" -s "$STYLE" &
	fi
}

reload() {
	echo "Reloading Waybar"
	killall waybar
	waybar -c "$CONFIG" -s "$STYLE" &
}

MODE=$1

if [[ $MODE == 'toggle' ]]; then
	toggle
fi

if [[ $MODE == 'reload' ]]; then
	reload
fi

if [[ $MODE == 'debug' ]]; then
	reload
fi
