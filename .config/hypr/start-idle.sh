#!/usr/bin/env bash

set -euo pipefail

pkill -x swayidle 2>/dev/null || true

exec swayidle -w \
  timeout 600 'pidof hyprlock || hyprlock' \
  timeout 900 'hyprctl dispatch dpms off' \
  resume 'hyprctl dispatch dpms on' \
  before-sleep 'pidof hyprlock || hyprlock' \
  lock 'pidof hyprlock || hyprlock'
