#!/usr/bin/env zsh
# Re-records every snapshot reference on the pinned environment (Scripts/snapshot-env.sh).
# The TEST_RUNNER_ prefix forwards SNAPSHOT_TESTING_RECORD into the test process, where
# SnapshotTesting reads it to decide the record mode.
# Usage: Scripts/record.sh
set -euo pipefail
cd "$(dirname "$0")/.."
export TEST_RUNNER_SNAPSHOT_TESTING_RECORD=all
exec Scripts/test.sh "$@"
