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
lab scope allow 192.0.2.0/24
lab scope deny 192.0.2.10
lab scope check 192.0.2.20
if lab scope check 192.0.2.10 >/dev/null 2>&1; then
  echo "Excluded scope unexpectedly passed." >&2
  exit 1
fi

lab target add 192.0.2.20 smoke
lab target use smoke
lab target list | grep -Fq smoke

printf 'ci evidence\n' > "$TMP/artifact.txt"
lab evidence add "$TMP/artifact.txt" smoke
lab evidence manifest
lab finding new "CI smoke finding" low
lab finding new "CI high finding" high
lab finding summary > "$TMP/finding-summary.txt"
lab validate > "$TMP/validation-before-report.txt"
lab report
lab validate > "$TMP/validation-after-report.txt"

ENGAGEMENT="$(cat "$HOME/.config/xlfr4n/lab/current")"
assert_file "$ENGAGEMENT/engagement.json"
assert_file "$ENGAGEMENT/08-evidence/index.tsv"
assert_file "$ENGAGEMENT/08-evidence/SHA256SUMS"
assert_file "$ENGAGEMENT/10-report/report.md"
assert_file "$ENGAGEMENT/10-report/report.html"
assert_file "$ENGAGEMENT/10-report/REPORT-SHA256SUMS"
grep -Eq '  report\.mdassert_contains "$ENGAGEMENT/10-report/report.md" "## Finding Summary"
assert_contains "$ENGAGEMENT/10-report/report.md" "Total       : 2"
assert_contains "$ENGAGEMENT/10-report/report.md" "CI smoke finding"
assert_contains "$ENGAGEMENT/10-report/report.md" "smoke"
assert_contains "$TMP/finding-summary.txt" "Total       : 2"
assert_contains "$TMP/finding-summary.txt" "High        : 1"
assert_contains "$TMP/finding-summary.txt" "Low         : 1"
assert_contains "$TMP/finding-summary.txt" "Open        : 2"
assert_contains "$TMP/validation-before-report.txt" "Engagement validation: PASS"
assert_contains "$TMP/validation-after-report.txt" "Engagement validation: PASS"

lab close
if lab exec --target smoke -- true >/dev/null 2>&1; then
  echo "Closed engagement unexpectedly allowed execution." >&2
  exit 1
fi

echo "Lab smoke test: PASS"
 "$ENGAGEMENT/10-report/REPORT-SHA256SUMS"
grep -Eq '  report\.htmlassert_contains "$ENGAGEMENT/10-report/report.md" "## Finding Summary"
assert_contains "$ENGAGEMENT/10-report/report.md" "Total       : 2"
assert_contains "$ENGAGEMENT/10-report/report.md" "CI smoke finding"
assert_contains "$ENGAGEMENT/10-report/report.md" "smoke"
assert_contains "$TMP/finding-summary.txt" "Total       : 2"
assert_contains "$TMP/finding-summary.txt" "High        : 1"
assert_contains "$TMP/finding-summary.txt" "Low         : 1"
assert_contains "$TMP/finding-summary.txt" "Open        : 2"
assert_contains "$TMP/validation-before-report.txt" "Engagement validation: PASS"
assert_contains "$TMP/validation-after-report.txt" "Engagement validation: PASS"

lab close
if lab exec --target smoke -- true >/dev/null 2>&1; then
  echo "Closed engagement unexpectedly allowed execution." >&2
  exit 1
fi

echo "Lab smoke test: PASS"
 "$ENGAGEMENT/10-report/REPORT-SHA256SUMS"
assert_contains "$ENGAGEMENT/10-report/report.md" "## Finding Summary"
assert_contains "$ENGAGEMENT/10-report/report.md" "Total       : 2"
assert_contains "$ENGAGEMENT/10-report/report.md" "CI smoke finding"
assert_contains "$ENGAGEMENT/10-report/report.md" "smoke"
assert_contains "$TMP/finding-summary.txt" "Total       : 2"
assert_contains "$TMP/finding-summary.txt" "High        : 1"
assert_contains "$TMP/finding-summary.txt" "Low         : 1"
assert_contains "$TMP/finding-summary.txt" "Open        : 2"
assert_contains "$TMP/validation-before-report.txt" "Engagement validation: PASS"
assert_contains "$TMP/validation-after-report.txt" "Engagement validation: PASS"

lab close
if lab exec --target smoke -- true >/dev/null 2>&1; then
  echo "Closed engagement unexpectedly allowed execution." >&2
  exit 1
fi

echo "Lab smoke test: PASS"
