#!/usr/bin/env bash

set -euo pipefail

config="$HOME/.config/hypr/hyprpaper.conf"

if ! command -v hyprpaper >/dev/null 2>&1; then
  exit 0
fi

if [ ! -f "$config" ]; then
  exit 0
fi

# Only start hyprpaper when the configured wallpaper path exists.
wallpaper_path="$(sed -n 's/^[[:space:]]*path = //p' "$config" | head -n1)"
wallpaper_path="${wallpaper_path/#\~/$HOME}"

if [ -z "$wallpaper_path" ] || [ ! -f "$wallpaper_path" ]; then
  exit 0
fi

pkill -x hyprpaper 2>/dev/null || true
exec hyprpaper --config "$config"
