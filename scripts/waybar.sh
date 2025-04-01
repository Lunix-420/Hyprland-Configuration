#!/bin/bash

CONFIG="$HOME/.config/hypr/waybar/config"
STYLE="$HOME/.config/hypr/waybar/style.css"

check_reserved() {
  json=$(hyprctl -j monitors)
  monitor=$(echo "$json" | jq ".[$id]")
  reserved_first=$(echo "$monitor" | jq '.reserved')
  first_numbers=$(echo "$reserved_first" | jq -s '.[0]')
  top_reserved=$(echo "$first_numbers" | jq -r '.[1]')
  echo "Top reserved are: ${top_reserved}"
  if [[ "$top_reserved" == "0" ]]; then
    echo "Reserved area not found"
    return 1
  else
    echo "Reserved area found"
    return 0
  fi
}

toggle() {
  echo "Toggling Waybar"
  if check_reserved; then
    echo "Resetting reserved area"
    hyprctl keyword monitor DP-1,addreserved,0,0,0,0
    hyprctl keyword monitor HDMI-A-1,addreserved,0,0,0,0
  else
    echo "Adjusting reserved area"
    hyprctl keyword monitor DP-1,addreserved,-20,0,0,0
    hyprctl keyword monitor HDMI-A-1,addreserved,-20,0,0,0
  fi
  killall -SIGUSR1 waybar
}

reload() {
  echo "Reloading Waybar"
  killall waybar
  waybar -c "$CONFIG" -s "$STYLE" &
  hyprctl keyword monitor DP-1,addreserved,-20,0,0,0
  hyprctl keyword monitor HDMI-A-1,addreserved,-20,0,0,0
}

MODE=$1

if [[ $MODE == 'toggle' ]]; then
  toggle
fi

if [[ $MODE == 'reload' ]]; then
  reload
fi
