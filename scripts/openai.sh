#!/usr/bin/env bash

firefox --no-remote -P ChatGPT --new-window https://chatgpt.com/
sleep 3s
hyprctl dispatch togglefloating
hyprctl dispatch resizeactive exact 1600 1000
hyprctl dispatch centerwindow

# Check if "chat-gpt" is running
# if pgrep "chat-gpt" >/dev/null; then
# 	echo "Process 'chat-gpt' is running. Killing it..."
# 	pkill "chat-gpt"
# else
# 	echo "Process 'chat-gpt' is not running. Starting it..."
# 	# Replace the following command with the actual command to start "chat-gpt"
# 	chat-gpt &
# fi
