#!/usr/bin/env bash

# rofi actions
case "$1" in
"app")
  pkill -x rofi || rofi -show drun -disable-history -show-icons -config "$HOME/.config/rofi/app-launcher.rasi"
  ;;
"window")
  pkill -x rofi || rofi -show window -config "$HOME/.config/rofi/window-switcher.rasi"
  ;;
"clip")
  pkill -x rofi || cliphist list | rofi -dmenu -p " " -display-columns 2 -config "$HOME/.config/rofi/clipboard.rasi" | cliphist decode | wl-copy
  ;;
"calc")
  pkill -x rofi || rofi -show calc -modi calc -no-show-match -no-sort -no-history -lines 0 -terse -config ".config/rofi/calculator.rasi" -hint-welcome "" -hint-result "" -kb-accept-entry ""
  ;;
"emoji")
  pkill -x rofi || rofi -modi emoji -show emoji -kb-secondary-copy "" -kb-custom-1 Ctrl+c -kb-accept-alt "" -config "$HOME/.config/rofi/emoji-picker.rasi" -emoji-format "<span font='12'>{emoji}</span>"
  ;;
"power")
  pkill -x rofi || "$HOME/.config/waybar/scripts/power-menu.sh"
  ;;
*)
  echo "Invalid argument"
  exit 1
  ;;
esac
