#!/usr/bin/env bash
# ⚡ xLFr4n // Kali BSPWM 2026
# CI smoke test for the local engagement lifecycle. No network activity is performed.

set -Eeuo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
cleanup(){ rm -rf "$TMP"; }
trap cleanup EXIT

export HOME="$TMP/home"
export XDG_CONFIG_HOME="$HOME/.config"
export XLFR4N_LAB_ROOT="$TMP/Lab"
export PATH="$ROOT/scripts:$PATH"

mkdir -p "$HOME"

assert_file(){ [ -f "$1" ] || { echo "Missing: $1" >&2; exit 1; }; }
assert_contains(){
  grep -Fq "$2" "$1" || {
    echo "Expected '$2' in $1" >&2
    exit 1
  }
}

lab init CI-Smoke
lab authorization set confirmed CI-SMOKE
lab scope allow 192.0.2.0/24
lab scope deny 192.0.2.10
lab scope check 192.0.2.20
if lab scope check 192.0.2.10 >/dev/null 2>&1; then
  echo "Excluded scope unexpectedly passed." >&2
  exit 1
fi

lab target add 192.0.2.20 smoke
lab target use smoke
if lab exec --target smoke -- sh -c 'printf blocked' >/dev/null 2>&1; then
  echo "Unauthorized execution unexpectedly passed." >&2
  exit 1
fi
lab authorization set confirmed CI-SMOKE
lab target list | grep -Fq smoke
lab doctor
lab doctor --strict
lab authorization status | grep -Fxq confirmed
lab finding summary | grep -Fq 'low        1'

printf 'ci evidence\n' > "$TMP/artifact.txt"
lab evidence add "$TMP/artifact.txt" smoke
lab evidence manifest
lab finding new "CI smoke finding" low
lab report

ENGAGEMENT="$(cat "$HOME/.config/xlfr4n/lab/current")"
assert_file "$ENGAGEMENT/engagement.json"
assert_file "$ENGAGEMENT/08-evidence/index.tsv"
assert_file "$ENGAGEMENT/08-evidence/SHA256SUMS"
assert_file "$ENGAGEMENT/10-report/report.md"
assert_file "$ENGAGEMENT/10-report/report.html"
assert_file "$ENGAGEMENT/10-report/REPORT-SHA256SUMS"
assert_contains "$ENGAGEMENT/10-report/report.md" "CI smoke finding"
assert_contains "$ENGAGEMENT/10-report/report.md" "smoke"
assert_contains "$ENGAGEMENT/10-report/report.md" "- low: 1"

echo "Lab smoke test: PASS"
