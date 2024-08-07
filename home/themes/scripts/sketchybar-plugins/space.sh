#!/bin/bash

source "$HOME/.config/sketchybar/color-scheme.sh"

if [ $SELECTED = true ]; then
  sketchybar --set space background.drawing=on \
                         background.color=$ACCENT_COLOR \
                         label.color=$BAR_COLOR \
                         icon.color=$BAR_COLOR
else
  sketchybar --set space background.drawing=off \
                         label.color=$ACCENT_COLOR \
                         icon.color=$ACCENT_COLOR
fi