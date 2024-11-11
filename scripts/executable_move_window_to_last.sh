#!/bin/bash

# The name of the window you want to keep as the last window
WINDOW_NAME="dotfiles"

# Get the ID of the window with the specified name
WINDOW_ID=$(tmux list-windows -F "#{window_id} #{window_name}" | grep "$WINDOW_NAME" | cut -d' ' -f1)

# Move the window to the last position
if [ -n "$WINDOW_ID" ]; then
  tmux move-window -t "$WINDOW_ID" -t -1
fi
