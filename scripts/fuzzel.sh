#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/fuzzel/fuzzel.ini"
if [[ ! $(pidof fuzzel) ]]; then
  fuzzel --config=${CONFIG} --log-level=info
else
  pkill fuzzel
fi
