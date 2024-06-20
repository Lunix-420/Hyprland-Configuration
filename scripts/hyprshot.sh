#!/usr/bin/env bash

MODE=$1

if [[ $MODE == 'fullscreen' ]]; then
	hyprshot -m output --freeze --clipboard-only
fi

if [[ $MODE == 'window' ]]; then
	hyprshot -m window --freeze --clipboard-only
fi

if [[ $MODE == 'select' ]]; then
	hyprshot -m region --freeze --clipboard-only
fi
