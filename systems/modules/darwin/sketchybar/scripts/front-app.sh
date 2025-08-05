#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set front_app label="$INFO" icon="$($HOME/.config/sketchybar/plugins/icon-map.sh "$INFO")"
fi