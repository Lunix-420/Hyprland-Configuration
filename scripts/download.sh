#!/usr/bin/env bash

# Define the network interface
INTERFACE="enp34s0"

# Run ifstat to capture the output
OUTPUT=$(ifstat "$INTERFACE" 1 1)

# Print the raw output for debugging
echo "$OUTPUT"

# Extract the RX Data/Rate (Download Rate) using awk
# Skip the first 3 lines (header and sample info) and get the RX Data/Rate from the relevant line
RX_RATE_KB=$(echo "$OUTPUT" | awk -v iface="$INTERFACE" '
    BEGIN { found=0 }
    $1 == iface { found=1 }
    found && NR==4 { print $6 }
')

# Remove the 'K' suffix and convert to MB/s
RX_RATE_MB=$(echo "$RX_RATE_KB" | sed 's/K//g' | awk '{printf "%.2f", $1 / 1024}')

# Format the result to always show two digits before the decimal point and one digit after
# Pad with spaces as needed to fit the format in monospace font
FORMATTED_RATE=$(printf "%5.1f" "$RX_RATE_MB")

# Print the formatted download rate
echo "$FORMATTED_RATE"
