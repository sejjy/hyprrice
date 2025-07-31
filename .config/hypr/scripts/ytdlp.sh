#!/usr/bin/env bash
set -e

RED="\033[1;31m"
GRN="\033[1;32m"
BLU="\033[1;34m"
RST="\033[0m"

if ! command -v yt-dlp &> /dev/null; then
  echo -e "${RED}Error: ${BLU}yt-dlp${RST} is not installed or not in PATH."
  exit 1
fi

URL="$1"
fmt="$2"
dir="$3"
name="$4"

if [[ "$URL" == "-h" || "$URL" == "--help" || -z "$URL" ]]; then
  echo -e "${RED}Usage: ${BLU}ytd ${GRN}<URL> <format> <directory> <name>${RST}"
  echo -e "Use '_' to skip optional arguments and use defaults."
  exit 0
fi

[[ -z "$fmt" || "$fmt" == "_" ]] && fmt="mp4"
[[ -z "$dir" || "$dir" == "_" ]] && dir="$HOME/Videos/Downloads"
[[ -z "$name" || "$name" == "_" ]] && name="%(title)s.%(ext)s"

if [[ "$fmt" == "mp3" ]]; then
  yt-dlp -f bestaudio -x --audio-format mp3 -o "${dir}/${name}" "$URL"
else
  yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "${dir}/${name}" "$URL"
fi
