#!/usr/bin/env zsh
# Runs the snapshot suite on the pinned reference environment (Scripts/snapshot-env.sh).
# Usage: Scripts/test.sh
set -euo pipefail
cd "$(dirname "$0")/.."
source Scripts/snapshot-env.sh

RUNTIME_ID="com.apple.CoreSimulator.SimRuntime.iOS-${NB_SNAPSHOT_OS//./-}"
DEVICE_TYPE_ID="com.apple.CoreSimulator.SimDeviceType.${NB_SNAPSHOT_DEVICE// /-}"

if ! xcrun simctl list runtimes -j | jq -e --arg id "$RUNTIME_ID" \
  '.runtimes[] | select(.identifier == $id)' >/dev/null; then
  echo "error: iOS $NB_SNAPSHOT_OS simulator runtime is not installed on this Mac." >&2
  echo "Install it with: xcodebuild -downloadPlatform iOS" >&2
  exit 1
fi

DEVICE_ID=$(xcrun simctl list devices -j | jq -r --arg rt "$RUNTIME_ID" --arg name "$NB_SNAPSHOT_DEVICE" \
  '(.devices[$rt] // []) | map(select(.name == $name)) | first | .udid // empty')

if [[ -z "$DEVICE_ID" ]]; then
  echo "Creating \"$NB_SNAPSHOT_DEVICE\" simulator on iOS $NB_SNAPSHOT_OS..."
  DEVICE_ID=$(xcrun simctl create "$NB_SNAPSHOT_DEVICE" "$DEVICE_TYPE_ID" "$RUNTIME_ID")
fi

# A simulator's first-ever boot (or a cold boot on a fresh CI runner) settles font/Dynamic
# Type caches slightly differently than a warm one, which shifts SwiftUI's sizeThatFits by a
# few points and makes the very next snapshot run mismatch its own reference. Booting
# explicitly and waiting for the boot to fully complete before xcodebuild ever touches the
# device avoids that: xcodebuild then attaches to an already-settled simulator instead of
# implicitly cold-booting one mid-test-run.
STATE=$(xcrun simctl list devices -j | jq -r --arg id "$DEVICE_ID" '.devices[][] | select(.udid == $id) | .state')
if [[ "$STATE" != "Booted" ]]; then
  echo "Booting \"$NB_SNAPSHOT_DEVICE\"..."
  xcrun simctl boot "$DEVICE_ID"
  xcrun simctl bootstatus "$DEVICE_ID" -b
fi


# Parallel testing makes xcodebuild clone the simulator ("Clone 1 of iPhone 16", ...) and boot
# those clones itself, bypassing the warm-up above and reintroducing the same cold-boot drift
# on whichever clone runs — this is forced off (last flag wins) regardless of what "$@" passes.
xcodebuild \
  -scheme NeoBrutalism \
  -destination "platform=iOS Simulator,name=$NB_SNAPSHOT_DEVICE,OS=$NB_SNAPSHOT_OS" \
  "$@" \
  -parallel-testing-enabled NO \
  test
