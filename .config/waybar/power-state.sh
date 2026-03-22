#!/usr/bin/env bash

set -euo pipefail

profile="$(powerprofilesctl get 2>/dev/null || echo balanced)"
battery_path="/sys/class/power_supply/BAT1"
capacity="?"
status="Unknown"

[ -f "$battery_path/capacity" ] && capacity="$(cat "$battery_path/capacity")"
[ -f "$battery_path/status" ] && status="$(cat "$battery_path/status")"

case "$profile" in
  performance)
    profile_icon=""
    profile_class="performance"
    ;;
  power-saver)
    profile_icon=""
    profile_class="power-saver"
    ;;
  *)
    profile_icon=""
    profile_class="balanced"
    ;;
esac

case "$status" in
  Charging|Full)
    battery_icon=""
    ;;
  *)
    battery_icon=""
    ;;
esac

battery_class="normal"
if [ "$capacity" != "?" ]; then
  if [ "$capacity" -le 12 ]; then
    battery_class="critical"
  elif [ "$capacity" -le 25 ]; then
    battery_class="warning"
  fi
fi

text="<span font_desc='Font Awesome 7 Free Solid 10'>${profile_icon}</span>  <span font_desc='Font Awesome 7 Free Solid 10'>${battery_icon}</span> ${capacity}%"
class="${profile_class} ${battery_class}"
tooltip="Power profile: ${profile}\nBattery: ${capacity}% (${status})\nClick: choose profile\nScroll: cycle profiles"

printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$class" "$tooltip"
