#!/bin/bash

# Detects if alacritty is running
if ! pgrep -f "alacritty" > /dev/null 2>&1; then
    /usr/bin/open -a "Alacritty"
else
    # Create a new window
    alacritty msg create-window > /dev/null 2>&1
fi

exit 0