#!/usr/bin/env bash

# save directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

# find the next available filename
find_next() {
  i=1
  while [ -e "$SCREENSHOT_DIR/Screenshot ($i).png" ]; do
    i=$((i + 1))
  done
  echo "Screenshot ($i).png"
}

# screenshot type
case "$1" in
"full")
  # full-screen screenshot
  FILENAME=$(find_next)
  grimblast copysave screen "$SCREENSHOT_DIR/$FILENAME"
  ;;
"partial")
  # partial screenshot with region selection
  FILENAME=$(find_next)
  grimblast copysave area "$SCREENSHOT_DIR/$FILENAME"
  # --freeze does not work
  ;;
*)
  echo "Invalid argument"
  exit 1
  ;;
esac

# check if the file is non-empty (valid screenshot)
if [ -s "$SCREENSHOT_DIR/$FILENAME" ]; then
  # notification
  notify-send "$FILENAME saved in $SCREENSHOT_DIR"
else
  # if the file is empty, remove it
  rm "$SCREENSHOT_DIR/$FILENAME"
fi
