#!/usr/bin/env bash

set -euo pipefail

direction="${1:-next}"
current="$(powerprofilesctl get 2>/dev/null || echo balanced)"

case "$current:$direction" in
  performance:next) target="balanced" ;;
  balanced:next) target="power-saver" ;;
  power-saver:next) target="performance" ;;
  performance:prev) target="power-saver" ;;
  balanced:prev) target="performance" ;;
  power-saver:prev) target="balanced" ;;
  *) target="balanced" ;;
esac

powerprofilesctl set "$target"
pkill -RTMIN+8 waybar 2>/dev/null || true
