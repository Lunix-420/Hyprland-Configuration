#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/alacritty/alacritty.toml"

if [ "$1" == "-f" ]; then
	alacritty --title "Floating Alacritty" --config-file "$CONFIG"
else
	alacritty --config-file "$CONFIG"
fi
