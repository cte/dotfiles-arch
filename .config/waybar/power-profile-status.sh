#!/usr/bin/env bash

set -euo pipefail

profile="$(powerprofilesctl get 2>/dev/null || echo balanced)"

case "$profile" in
  performance)
    icon=""
    class="performance"
    ;;
  power-saver)
    icon=""
    class="power-saver"
    ;;
  *)
    icon=""
    class="balanced"
    ;;
esac

printf '{"text":"<span font_desc='\''Font Awesome 7 Free Solid 10'\''>%s</span>","class":"%s","tooltip":"Power profile: %s\\nClick: choose profile\\nScroll: cycle profiles"}\n' \
  "$icon" "$class" "$profile"
