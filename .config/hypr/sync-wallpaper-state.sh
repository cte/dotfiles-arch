#!/usr/bin/env bash

set -euo pipefail

wallpaper="${1:-}"
config="${HOME}/.config/hypr/hyprpaper.conf"

wallpaper="${wallpaper/#\~/$HOME}"

if [ -z "$wallpaper" ] || [ ! -f "$wallpaper" ] || [ ! -f "$config" ]; then
  exit 0
fi

tmp_config="$(mktemp)"
awk -v path="$wallpaper" '
  BEGIN { updated = 0 }
  /^[[:space:]]*path = / && !updated {
    print "    path = " path
    updated = 1
    next
  }
  { print }
' "$config" > "$tmp_config"
mv "$tmp_config" "$config"
