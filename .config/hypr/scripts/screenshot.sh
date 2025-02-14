#!/usr/bin/env bash

# save directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
DISPLAY_PATH="${SCREENSHOT_DIR#"$HOME"/}"

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
"screen")
  # all visible outputs
  FILENAME=$(find_next)
  grimblast copysave screen "$SCREENSHOT_DIR/$FILENAME"
  ;;
"area")
  # manually select a region or window
  FILENAME=$(find_next)
  grimblast --freeze copysave area "$SCREENSHOT_DIR/$FILENAME"
  ;;
*)
  echo "Invalid argument"
  exit 1
  ;;
esac

# check if the file is non-empty (valid screenshot)
if [ -s "$SCREENSHOT_DIR/$FILENAME" ]; then
  # notification
  notify-send -i "$SCREENSHOT_DIR/$FILENAME" "$FILENAME saved in ~/$DISPLAY_PATH"
else
  # if the file is empty, remove it
  rm "$SCREENSHOT_DIR/$FILENAME"
fi
