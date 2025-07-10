#!/usr/bin/env bash

# this script removes orphaned packages and clears package cache for both pacman and yay.
# it keeps one (1) current and two (2) old versions of each package.

YAY_CACHE_DIR="$HOME/.cache/yay"

# remove orphaned packages
echo -e "\n\033[1;34mRemoving orphaned packages...\033[0m"
orphans=$(pacman -Qtdq)
if [[ -n "$orphans" ]]; then
  sudo pacman -Rns "$orphans"
else
  echo "No orphaned packages found."
fi

# clear package cache
echo -e "\n\033[1;34mClearing package cache...\033[0m"
sudo paccache -rk2 2>/dev/null
sudo paccache -ruk0 2>/dev/null # remove all for uninstalled

# prune old AUR package cache
echo -e "\n\033[1;34mPruning old AUR package cache...\033[0m"
if [[ -d "$YAY_CACHE_DIR" ]]; then
  paccache -rk2 --cachedir "$YAY_CACHE_DIR"
else
  echo -e "\033[1;31mYay cache directory not found.\033[0m"
fi

echo -e "\n\033[1;32mCleanup complete!\033[0m"
