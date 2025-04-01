#!/usr/bin/env bash

check_floating() {
  json=$(hyprctl -j activewindow)
  floating=$(echo "$json" | jq -r '.floating')
  if [[ "$floating" == "true" ]]; then
    echo "The active window is floating."
    return 0
  else
    echo "The active window is tiled."
    return 1
  fi
}

hyprctl dispatch togglefloating

if check_floating; then
  hyprctl dispatch resizeactive exact 1600 1000
  hyprctl dispatch centerwindow
fi
