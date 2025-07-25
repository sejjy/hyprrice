#!/usr/bin/env bash

RED="\033[1;31m"
GRN="\033[1;32m"
BLU="\033[1;34m"
RST="\033[0m"

URL="$1"
fmt="$2"
dir="$3"
name="$4"

if [[ -z "$fmt" ]] || [[ "$fmt" == "_" ]]; then
  fmt="mp4"
fi

if [[ -z "$dir" ]] || [[ "$dir" == "_" ]]; then
  dir="$HOME/Videos/Downloads"
fi

if [[ -z "$name" ]] || [[ "$name" == "_" ]]; then
  name="%(title)s.%(ext)s"
fi

if [[ -z "$URL" ]]; then
  echo -e "${RED}Usage:${RST} ${BLU}ytd${RST} ${GRN}<URL>${RST} ${GRN}<format>${RST} ${GRN}<directory>${RST} ${GRN}<name>${RST}"
  exit 1
elif [[ "$fmt" == "mp3" ]]; then
  yt-dlp -f bestaudio -x --audio-format mp3 -o "$dir/$name" "$URL"
else
  yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "$dir/$name" "$URL"
fi
