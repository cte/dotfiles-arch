#!/usr/bin/env bash

set -euo pipefail

profile="$(powerprofilesctl get 2>/dev/null || echo balanced)"

case "$profile" in
  performance)
    icon=""
    label="perf"
    class="performance"
    ;;
  power-saver)
    icon=""
    label="save"
    class="power-saver"
    ;;
  *)
    icon=""
    label="bal"
    class="balanced"
    ;;
esac

printf '{"text":"<span font_desc='\''Font Awesome 7 Free Solid 10'\''>%s</span> \u2009%s","class":"%s","tooltip":"Power profile: %s\\nClick: choose profile\\nScroll: cycle profiles"}\n' \
  "$icon" "$label" "$class" "$profile"
