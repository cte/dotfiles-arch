#!/usr/bin/env bash

set -euo pipefail

pkill -f 'wl-paste --type text --watch cliphist store' 2>/dev/null || true
pkill -f 'wl-paste --type image --watch cliphist store' 2>/dev/null || true
pkill -f 'wl-paste --primary --type text --watch cliphist store' 2>/dev/null || true

setsid -f sh -c 'exec wl-paste --type text --watch cliphist store >/tmp/cliphist-text.log 2>&1'
setsid -f sh -c 'exec wl-paste --primary --type text --watch cliphist store >/tmp/cliphist-primary.log 2>&1'
setsid -f sh -c 'exec wl-paste --type image --watch cliphist store >/tmp/cliphist-image.log 2>&1'
