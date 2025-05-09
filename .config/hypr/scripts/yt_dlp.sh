#!/usr/bin/env bash

url="$1"
fmt="$2"
dir="$3"
name="$4"
red="\033[1;31m"
grn="\033[1;32m"
blu="\033[1;34m"
res="\033[0m"

if [[ -z "$fmt" ]] || [[ "$fmt" == "_" ]]; then
  fmt="mp4"
fi

if [[ -z "$dir" ]] || [[ "$dir" == "_" ]]; then
  dir="$HOME/Videos/Downloads"
fi

if [[ -z "$name" ]] || [[ "$name" == "_" ]]; then
  name="%(title)s.%(ext)s"
fi

if [[ -z "$url" ]]; then
  echo -e "${red}Usage:${res} ${blu}ytd${res} ${grn}<URL>${res} ${grn}<format>${res} ${grn}<directory>${res} ${grn}<name>${res}"
  exit 1
elif [[ "$fmt" == "mp3" ]]; then
  yt-dlp -f bestaudio -x --audio-format mp3 -o "$dir/$name" "$url"
else
  yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "$dir/$name" "$url"
fi
