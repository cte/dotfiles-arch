#!/usr/bin/env bash
set -euo pipefail

pkill waybar || true
sleep 0.2
hyprctl dispatch exec "waybar >/tmp/waybar.log 2>&1"
