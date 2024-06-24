#!/usr/bin/env bash

# Define zero character (adjust as needed)
ZERO_CHARACTER=" "

# Define the icon to me shown
ICON=🖥️ #󰍹 

# Query GPU utilization and strip non-digit characters
utilization=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader | tr -dc '[:digit:]')

# Pad utilization with zero if single digit
if [ ${#utilization} -eq 1 ]; then
	utilization="${ZERO_CHARACTER}${utilization}"
fi

# Query GPU temperature and strip non-digit characters
temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | tr -dc '[:digit:]')

# Pad temperature with zero if single digit
if [ ${#temp} -eq 1 ]; then
	temp="${ZERO_CHARACTER}${temp}"
fi

icon_span="<span font-desc='Comic Sans MS 18px'>${ICON} </span>"

echo "${icon_span}${utilization}% | ${temp}°C"
