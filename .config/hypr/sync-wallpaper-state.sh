#!/usr/bin/env bash

set -euo pipefail

wallpaper="${1:-}"
hyprpaper_config="${HOME}/.config/hypr/hyprpaper.conf"
hyprlock_config="${HOME}/.config/hypr/hyprlock.conf"

wallpaper="${wallpaper/#\~/$HOME}"

if [ -z "$wallpaper" ] || [ ! -f "$wallpaper" ]; then
  exit 0
fi

update_first_path() {
  local config="$1"
  local resolved_config
  local tmp_config

  [ -f "$config" ] || return 0
  resolved_config="$(readlink -f "$config" 2>/dev/null || printf '%s' "$config")"

  tmp_config="$(mktemp)"
  awk -v path="$wallpaper" '
    BEGIN { updated = 0 }
    /^[[:space:]]*path = / && !updated {
      print "    path = " path
      updated = 1
      next
    }
    { print }
  ' "$resolved_config" > "$tmp_config"
  mv "$tmp_config" "$resolved_config"
}

update_first_path "$hyprpaper_config"
update_first_path "$hyprlock_config"
