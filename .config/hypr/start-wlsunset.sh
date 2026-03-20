#!/usr/bin/env bash

set -euo pipefail

pkill -x wlsunset 2>/dev/null || true

# Conservative manual schedule to avoid needing geolocation.
exec wlsunset -T 6500 -t 4000 -S 07:00 -s 19:00 -d 1800
