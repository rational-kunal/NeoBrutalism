#!/usr/bin/env zsh
# Re-records every snapshot reference on the pinned environment (Scripts/snapshot-env.sh).
# The TEST_RUNNER_ prefix forwards SNAPSHOT_TESTING_RECORD into the test process, where
# SnapshotTesting reads it to decide the record mode.
#
# Recording makes every snapshot assertion report itself as a failing "issue" (e.g. "Record
# mode is on. Automatically recorded snapshot: ..."), so the test action's exit code is always
# non-zero here even when nothing went wrong. This can't use `set -e` on that command — it
# inspects the exit code itself, and only a real compile error ("** BUILD FAILED **") or a
# crashed test host is treated as an actual failure; a run full of recorded-reference issues is
# expected and tolerated.
# Usage: Scripts/record.sh
set -uo pipefail
cd "$(dirname "$0")/.."
export TEST_RUNNER_SNAPSHOT_TESTING_RECORD=all

LOG_FILE=$(mktemp)
trap 'rm -f "$LOG_FILE"' EXIT

Scripts/test.sh "$@" 2>&1 | tee "$LOG_FILE"
STATUS=$pipestatus[1]

if [[ $STATUS -eq 0 ]]; then
  exit 0
fi

if grep -qE '\*\* BUILD FAILED \*\*|Restarting after unexpected exit|Early unexpected exit|Fatal error:|EXC_BAD_ACCESS' "$LOG_FILE"; then
  echo "error: recording run failed for a real reason (build error or crash), not just recorded snapshots." >&2
  exit 1
fi

echo "Recording complete — the 'failures' above are expected in record mode (every recorded snapshot reports itself as one)."
