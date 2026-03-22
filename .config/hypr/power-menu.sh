#!/usr/bin/env bash
set -euo pipefail

ROFI_BIN="${ROFI_BIN:-/usr/bin/rofi}"

choice="$(
  printf '%s\n' \
    'lock' \
    'logout' \
    'suspend' \
    'hibernate' \
    'reboot' \
    'shutdown' \
  | "${ROFI_BIN}" -dmenu -i -p power
)"

case "${choice:-}" in
  lock)
    exec /usr/bin/hyprlock
    ;;
  logout)
    exec /usr/bin/hyprctl dispatch exit
    ;;
  suspend)
    exec /usr/bin/bash -lc '/usr/bin/loginctl lock-session && /usr/bin/systemctl suspend'
    ;;
  hibernate)
    exec /usr/bin/systemctl hibernate
    ;;
  reboot)
    exec /usr/bin/systemctl reboot
    ;;
  shutdown)
    exec /usr/bin/systemctl poweroff
    ;;
  *)
    exit 0
    ;;
esac
