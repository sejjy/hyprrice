#!/usr/bin/env bash

# variables
TEXT_COLOR="#cdd6f4"
SPOTIFY_ICON="<span color='#a6e3a1'>󰓇 </span>"
FIREFOX_ICON="<span color='#f38ba8'>󰗃 </span>"
PAUSE_ICON="<span color='#b4befe'>  󰏤 </span>"
# PAUSE_ICON="<span color='#b4befe'>\u200A\u200A󰏤\u2009\u2009</span>"
# this uses hair spaces and thin spaces

# function to escape ampersand (&)
escape_markup() {
  local text="$1"
  text="${text//&/&amp;}"
  echo "$text"
}

# list active players
players=$(playerctl --list-all)

format_output() {
  local player="$1"
  local status
  local artist
  local title
  local icon
  local text

  # get playback status, artist, and title
  status=$(playerctl --player="$player" status 2>/dev/null)
  artist=$(playerctl --player="$player" metadata artist 2>/dev/null)
  title=$(playerctl --player="$player" metadata title 2>/dev/null)

  # escape special characters
  artist=$(escape_markup "$artist")
  title=$(escape_markup "$title")

  # icon based on player and status
  if [[ "$status" == "Playing" ]]; then
    if [[ "$player" == *"spotify"* ]]; then
      icon="$SPOTIFY_ICON"
    elif [[ "$player" == *"firefox"* ]]; then
      icon="$FIREFOX_ICON"
    else
      icon=""
    fi
  elif [[ "$status" == "Paused" ]]; then
    icon="$PAUSE_ICON"
  else
    icon=""
  fi

  # track info
  if [[ -n "$artist" && -n "$title" ]]; then
    text="${icon}  <span color='${TEXT_COLOR}'>${title} — ${artist}</span>"
  elif [[ -n "$title" ]]; then
    text="${icon}  <span color='${TEXT_COLOR}'>${title}</span>"
  else
    text=""
  fi

  [[ -n "$text" ]] && echo "$text"
}

# loop through players
for player in $players; do
  if [[ $(playerctl --player="$player" status 2>/dev/null) == "Playing" ]]; then
    format_output "$player"
    exit 0
  fi
done

# if no players are playing, show the first player
if [[ -n "$players" ]]; then
  format_output "$(echo "$players" | head -n 1)"
fi
