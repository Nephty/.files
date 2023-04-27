#! /bin/bash

CFG="$HOME/.config/wofi/launcher/config"
STYLE="$HOME/.config/wofi/style.css"


if [[ -z "$(pidof wofi)" ]];then
  wofi -c "$CFG" -s "$STYLE" -b -i --show drun
else
  killall wofi
fi
