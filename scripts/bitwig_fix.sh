#!/bin/bash
# Daemon to manage focus dynamically

BITWIG_CLASS="bitwig-studio"
HYPRCTL=$(which hyprctl)

while true; do
	CURRENT_WS=$($HYPRCTL activeworkspace)
	CURRENT_WINDOW=$($HYPRCTL activewindow | grep class | awk '{print $2}')

	if [ "$CURRENT_WS" == "1" ] && [ "$CURRENT_WINDOW" == "$BITWIG_CLASS" ]; then
		$HYPRCTL keyword windowrulev2 "stayfocused, class:$BITWIG_CLASS"
		echo "FOCUS"
	else
		$HYPRCTL keyword windowrule "nofocus, class:$BITWIG_CLASS"
		echo "UNFOCUS"
	fi
	sleep 1
done
