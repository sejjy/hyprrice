#!/usr/bin/env bash

player=$(playerctl metadata --format "{{ playerName }}")

if [[ $player == "firefox" ]]; then
	icon="<span color='#f38ba8'>󰗃 </span>"
elif [[ $player == spotify* ]]; then
	icon="<span color='#a6e3a1'>󰓇 </span>"
else
	icon="󰐊 "
fi

status=$(playerctl metadata --format "{{ status }}")

if [[ $status != "Playing" ]]; then
	icon="󰏤 "
fi

title=$(playerctl metadata --format "{{ title }}")
artist=$(playerctl metadata --format "{{ artist }}")

output="${title} — ${artist}"

maxlen=40
outlen=${#output}

if ((outlen > maxlen)); then
	output="${output:0:$((maxlen - 3))}..."
fi

output=$(playerctl metadata --format "$icon  $output")

echo "$output"
