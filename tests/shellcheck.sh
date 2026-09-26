#!/usr/bin/env bash
set -euo pipefail
if ! command -v shellcheck >/dev/null 2>&1; then echo "shellcheck is not installed; skipping."; exit 0; fi
shellcheck install.sh uninstall.sh scripts/* config/bspwm/bspwmrc config/sxhkd/sxhkdrc config/polybar/launch.sh
