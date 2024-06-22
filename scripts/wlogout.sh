#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/wlogout/style.css"
LAYOUT="$HOME/.config/hypr/wlogout/layout"

wlogout -C $CONFIG -l $LAYOUT &
