#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON="<U+1006E8>"
  ;;
  [6-8][0-9]) ICON="<U+100EB8>"
  ;;
  [3-5][0-9]) ICON="<U+100EB6>"
  ;;
  [1-2][0-9]) ICON="<U+1006E9>"
  ;;
  *) ICON="<U+1006EA>"
esac

if [[ $CHARGING != "" ]]; then
  ICON="<U+10088B>"
fi

sketchybar --set $NAME icon="$ICON" label="${PERCENTAGE}%"