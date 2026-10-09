#!/usr/bin/env bash
# TRAINING FIXTURE, but this version (v1.1) is SAFE. It only prints a coverage
# summary. The compromise is introduced in v1.2. See README.md.
set -uo pipefail

# A real, harmless coverage summary.
if [[ -f "${REPORT_PATH:-}" ]]; then
  echo "Coverage summary: $(cat "${REPORT_PATH}")"
else
  echo "Coverage summary: no report at ${REPORT_PATH:-<unset>}, skipping."
fi
