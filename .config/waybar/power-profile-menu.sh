#!/usr/bin/env bash

set -euo pipefail

choice="$(
  printf 'performance\nbalanced\npower-saver\n' |
    rofi -dmenu -i -p profile
)"

[ -n "${choice:-}" ] || exit 0

powerprofilesctl set "$choice"
pkill -RTMIN+8 waybar 2>/dev/null || true
