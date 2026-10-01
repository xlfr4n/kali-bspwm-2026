#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
pass=0
fail=0
check(){
  local label="$1"
  shift
  if "$@"; then printf '[PASS] %s\n' "$label"; pass=$((pass+1)); else printf '[FAIL] %s\n' "$label" >&2; fail=$((fail+1)); fi
}
check 'VirtualBox helper exists' test -s tools/virtualbox/xlfr4n-lab-vbox.ps1
check 'DC provisioner exists' test -s tools/ad-lab/Provision-DC.ps1
check 'AD join helper exists' test -s tools/ad-lab/Join-Client.ps1
check 'AD validator exists' test -s tools/ad-lab/Test-ADLab.ps1
check 'Web app exists' test -s tools/web-lab/app.py
check 'Web Dockerfile exists' test -s tools/web-lab/Dockerfile
check 'Web compose exists' test -s tools/web-lab/compose.yml
check 'Web reset exists' test -s tools/web-lab/reset.sh
check 'Web smoke exists' test -s tools/web-lab/test.sh
check 'Web mode guard' sh -c "grep -Fq 'LAB_MODE' tools/web-lab/app.py && grep -Fq 'isolated-lab' tools/web-lab/app.py"
check 'Web compose mode' grep -Fq 'LAB_MODE: isolated-lab' tools/web-lab/compose.yml
check 'Web non-root user' grep -Fq 'USER weblab' tools/web-lab/Dockerfile
check 'Web no automatic restart' grep -Fq 'restart: "no"' tools/web-lab/compose.yml
check 'Web localhost binding by default' grep -Fq 'WEB_LAB_BIND:-127.0.0.1' tools/web-lab/compose.yml
check 'Web drop capabilities' grep -Fq 'cap_drop:' tools/web-lab/compose.yml
check 'Web read-only filesystem' grep -Fq 'read_only: true' tools/web-lab/compose.yml
check 'VirtualBox atomic apply guard' grep -Fq '$notPoweredOff' tools/virtualbox/xlfr4n-lab-vbox.ps1
check 'VirtualBox post-apply verification' grep -Fq 'Post-apply verification failed' tools/virtualbox/xlfr4n-lab-vbox.ps1
check 'Snapshot existence guard' grep -Fq 'was not found on' tools/virtualbox/xlfr4n-lab-snapshot.ps1
check 'Snapshot reset confirmation' grep -Fq 'RESET' tools/virtualbox/xlfr4n-lab-snapshot.ps1
check 'Web search smoke route' grep -Fq 'synthetic search surface' tools/web-lab/test.sh
bash -n tools/web-lab/reset.sh
bash -n tools/web-lab/test.sh
python3 -m py_compile tools/web-lab/app.py
printf '\nLab stage asset checks: %d PASS, %d FAIL\n' "$pass" "$fail"
exit "$fail"
