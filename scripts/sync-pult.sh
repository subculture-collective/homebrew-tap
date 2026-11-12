#!/usr/bin/env bash
# Copies the formula from Pult's newest release into Formula/pult.rb.
# Prints the release tag; exits 0 whether or not the file changed.
set -euo pipefail

api=https://git.subcult.tv/api/v1/repos/subculture-collective/pult/releases
# Data bundles (bundle-*) are releases too; the app's tags start with v.
tag=$(curl -fsS "${api}?limit=50" | python3 -c '
import json, sys
for r in json.load(sys.stdin):
    if r["tag_name"].startswith("v") and not r["draft"] and not r["prerelease"]:
        print(r["tag_name"]); break
')
test -n "${tag}" || { echo "sync-pult: no v* release found" >&2; exit 1; }
tmp=$(mktemp)
curl -fsSL -o "${tmp}" "https://git.subcult.tv/subculture-collective/pult/releases/download/${tag}/pult.rb"
# Drop the template comment the release copy keeps on its first line.
sed '1{/^# Template/d}' "${tmp}" > Formula/pult.rb
rm -f "${tmp}"
echo "${tag}"
