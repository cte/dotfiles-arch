#!/usr/bin/env bash
set -euo pipefail

CAMERA_DEVICE="/dev/video0"

for _ in $(seq 1 20); do
  if [ -e "${CAMERA_DEVICE}" ]; then
    /usr/bin/v4l2-ctl -d "${CAMERA_DEVICE}" --set-ctrl=exposure_dynamic_framerate=0 >/dev/null 2>&1 || true
    exit 0
  fi
  sleep 0.5
done

exit 0
