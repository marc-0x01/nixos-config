#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO" icon="$(./icon_map.sh "$INFO")"
fi