#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($HOME/.config/sketchybar/plugins/icon-map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --set space.$space label="$icon_strip"
fi