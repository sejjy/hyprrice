#!/usr/bin/env bash

# rofi actions
case "$1" in
"app")
  pkill -x rofi || rofi -show drun -config "$HOME/.config/rofi/app-launcher.rasi"
  ;;
"window")
  pkill -x rofi || rofi -show window -config "$HOME/.config/rofi/window-switcher.rasi"
  ;;
"clipboard")
  pkill -x rofi || cliphist list | rofi -dmenu -p " " -display-columns 2 -config "$HOME/.config/rofi/clipboard.rasi" | cliphist decode | wl-copy
  ;;
"power")
  pkill -x rofi || "$HOME/.config/waybar/scripts/power-menu.sh"
  ;;
*)
  echo "Invalid argument"
  exit 1
  ;;
esac
