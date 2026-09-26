#!/usr/bin/env bash
set -u
killall -q polybar 2>/dev/null || true
while pgrep -x polybar >/dev/null 2>&1; do sleep 0.2; done
polybar main -c "$HOME/.config/polybar/config.ini" >/tmp/kali-bspwm-polybar.log 2>&1 &
