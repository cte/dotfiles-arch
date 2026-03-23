#!/usr/bin/env bash
set -euo pipefail

pkill hypridle || true
sleep 0.2
setsid -f /usr/bin/hypridle -v >/tmp/hypridle.log 2>&1
