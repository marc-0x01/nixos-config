#!/bin/bash

BAR_COLOR=0xff${config.lib.stylix.colors.base00}
ACCENT_COLOR=0xff${config.lib.stylix.colors.base04}

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