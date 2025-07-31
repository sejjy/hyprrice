#!/usr/bin/env bash

# rofi actions
case "$1" in
  "A")
    pkill -x rofi ||
      rofi -show drun -disable-history -show-icons \
      -config "$HOME/.config/rofi/app-launcher.rasi"
    ;;
  "V")
    pkill -x rofi ||
      cliphist list | rofi -dmenu -p " " -display-columns 2 \
      -config "$HOME/.config/rofi/clipboard.rasi" | cliphist decode | wl-copy
    ;;
  "X")
    pkill -x rofi ||
      rofi -show calc -modi calc -no-show-match -no-sort -no-history -lines 0 \
      -terse -config ".config/rofi/calculator.rasi" \
      -hint-welcome "" -hint-result "" -kb-accept-entry ""
    ;;
  "M")
    pkill -x rofi ||
      rofi -modi emoji -show emoji \
      -kb-secondary-copy "" -kb-custom-1 Ctrl+c -kb-accept-alt "" \
      -config "$HOME/.config/rofi/emoji-picker.rasi" \
      -emoji-format "<span font='12'>{emoji}</span>"
    ;;
  "W")
    pkill -x rofi ||
      rofi -show window -config "$HOME/.config/rofi/window-switcher.rasi"
    ;;
  *)
    echo "Invalid argument"
    exit 1
    ;;
esac
