#!/usr/bin/env bash

# Define zero character (adjust as needed)
ZERO_CHARACTER=" "

# Define the icon to be shown
ICON=🧠 # 󰍛"

# Get CPU temperature using lm_sensors
cpu_temp=$(sensors | grep 'Tctl' | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
cpu_temp=${cpu_temp%%.*} # Remove decimal part

# Cap CPU temperature at 99
if [ "$cpu_temp" -gt 99 ]; then
	cpu_temp=99
fi

# Pad temperature with zero if single digit
if [ ${#cpu_temp} -eq 1 ]; then
	cpu_temp="${ZERO_CHARACTER}${cpu_temp}"
fi

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
cpu_usage=${cpu_usage%%.*} # Remove decimal part

# Cap CPU usage at 99
if [ "$cpu_usage" -gt 99 ]; then
	cpu_usage=99
fi

# Pad usage with zero if single digit
if [ ${#cpu_usage} -eq 1 ]; then
	cpu_usage="${ZERO_CHARACTER}${cpu_usage}"
fi

icon_span="<span font-desc='CpuIcon 19px'>${ICON} </span>"

# Output the formatted variables
echo "${icon_span}${cpu_usage}% | ${cpu_temp}°C"
