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
lab topology validate
sed -i \
  -e 's/^- Hipervisor:$/- Hipervisor: VirtualBox/' \
  -e 's/^- Modo de red:$/- Modo de red: Internal Network/' \
  -e 's/^- Nombre de red:$/- Nombre de red: XLFR4N-LAB/' \
  -e 's/^- Subred:$/- Subred: 10.77.0.0\/24/' \
  -e 's/| DC01 | | AD\/DNS | | |/| DC01 | 10.77.0.10 | AD\/DNS | DC01 | DC01-domain-ready |/' \
  -e 's/| WS01 | | Windows client | | |/| WS01 | 10.77.0.20 | Windows client | WS01 | WS01-joined |/' \
  -e 's/| WEB01 | | Web target | | |/| WEB01 | 10.77.0.30 | Web target | WEB01 | WEB01-clean |/' \
  -e 's/^- Snapshot utilizado antes del ejercicio:$/- Snapshot utilizado antes del ejercicio: baseline/' \
  "$XLFR4N_LAB_ROOT/ci-smoke/00-scope/TOPOLOGY.md"
lab topology validate --strict
lab topology show | grep -Fq 'XLFR4N-LAB'
lab scope deny 192.0.2.10
lab scope check 192.0.2.20
if lab scope check 192.0.2.10 >/dev/null 2>&1; then
  echo "Excluded scope unexpectedly passed." >&2
  exit 1
fi

lab target add 192.0.2.20 smoke
lab target use smoke
lab authorization set pending
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
printf "tampered\n" > "$(find "$ENGAGEMENT/08-evidence/raw" -type f -name "*artifact.txt" -print -quit)"
if lab evidence verify >/dev/null 2>&1; then
  echo "Tampered evidence unexpectedly verified." >&2
  exit 1
fi
printf "ci evidence\n" > "$TMP/artifact.txt"
lab evidence add "$TMP/artifact.txt" smoke
lab evidence manifest
lab evidence verify
lab evidence manifest
lab evidence verify
lab finding new "CI smoke finding" low
lab finding set F-001 status confirmed
grep -Fq "**Status:** confirmed" "$ENGAGEMENT/09-findings/F-001-ci-smoke-finding.md"
lab finding summary | grep -Fq 'low        1'
lab report

ENGAGEMENT="$(cat "$HOME/.config/xlfr4n/lab/current")"
assert_file "$ENGAGEMENT/engagement.json"
assert_file "$ENGAGEMENT/notes/timeline.log"
assert_contains "$ENGAGEMENT/notes/timeline.log" "authorization changed to confirmed"
assert_contains "$ENGAGEMENT/notes/timeline.log" "scope allow: 192.0.2.0/24"
assert_contains "$ENGAGEMENT/notes/timeline.log" "target added: smoke"
assert_contains "$ENGAGEMENT/notes/timeline.log" "active target selected: smoke"
assert_file "$ENGAGEMENT/08-evidence/index.tsv"
assert_file "$ENGAGEMENT/08-evidence/SHA256SUMS"
assert_file "$ENGAGEMENT/10-report/report.md"
assert_file "$ENGAGEMENT/10-report/report.html"
assert_file "$ENGAGEMENT/10-report/REPORT-SHA256SUMS"
assert_contains "$ENGAGEMENT/10-report/report.md" "CI smoke finding"
assert_contains "$ENGAGEMENT/10-report/report.md" "smoke"
assert_contains "$ENGAGEMENT/10-report/report.md" "- low: 1"
assert_contains "$ENGAGEMENT/10-report/report.md" "## Engagement timeline"

echo "Lab smoke test: PASS"
