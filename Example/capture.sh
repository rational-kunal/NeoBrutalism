#!/usr/bin/env zsh
# Boots a simulator, builds the Example app, and records screenshots + a demo video
# for README material. Usage: ./capture.sh [simulator-name]
#
# Walks you through capturing all three tabs (Todo, Gallery, Themes) in light and dark
# mode, plus a short demo video, into docs/media/. There's no reliable way to drive taps
# on the simulator from a script, so this pauses at each step and waits for you to
# position the app by hand (switch tabs, toggle dark mode) before it takes the shot —
# dumb, but it always works.
#
# Requires: Xcode command line tools. Optional: ffmpeg (brew install ffmpeg) to also
# produce demo.gif automatically; otherwise the command to do it by hand is printed.
set -euo pipefail
cd "$(dirname "$0")"

SIM_NAME="${1:-iPhone 16}"
BUNDLE_ID="wtf.rational.Example"
OUT_DIR="$(cd .. && pwd)/docs/media"
mkdir -p "$OUT_DIR"

DEVICE_ID=$(xcrun simctl list devices -j | jq -r --arg name "$SIM_NAME" \
  '.devices | to_entries[] | .value[] | select(.name == $name and .isAvailable) | .udid' | head -n1)

if [[ -z "$DEVICE_ID" ]]; then
  echo "error: no available simulator named \"$SIM_NAME\" found." >&2
  echo "Create one in Xcode (Window > Devices and Simulators) or pass a different name." >&2
  exit 1
fi

STATE=$(xcrun simctl list devices -j | jq -r --arg id "$DEVICE_ID" '.devices[][] | select(.udid == $id) | .state')
if [[ "$STATE" != "Booted" ]]; then
  echo "Booting \"$SIM_NAME\"..."
  xcrun simctl boot "$DEVICE_ID"
  xcrun simctl bootstatus "$DEVICE_ID" -b
fi

open -a Simulator --args -CurrentDeviceUDID "$DEVICE_ID"

echo "Building Example..."
DERIVED_DATA=$(mktemp -d)
trap 'rm -rf "$DERIVED_DATA"' EXIT

xcodebuild \
  -scheme Example \
  -project Example.xcodeproj \
  -destination "platform=iOS Simulator,id=$DEVICE_ID" \
  -derivedDataPath "$DERIVED_DATA" \
  build

APP_PATH="$DERIVED_DATA/Build/Products/Debug-iphonesimulator/Example.app"
xcrun simctl install "$DEVICE_ID" "$APP_PATH"
xcrun simctl terminate "$DEVICE_ID" "$BUNDLE_ID" 2>/dev/null || true
xcrun simctl launch "$DEVICE_ID" "$BUNDLE_ID"

capture() {
  local name="$1"
  read "?Press Enter to capture ${name}.png... "
  xcrun simctl io "$DEVICE_ID" screenshot "$OUT_DIR/$name.png"
  echo "Saved docs/media/$name.png"
}

echo ""
echo "=== Light mode screenshots ==="
echo "The app launches in light mode and on the Todo tab by default."
capture "todo-light"
read "?Switch to the Gallery tab, then press Enter... "
capture "gallery-light"
read "?Switch to the Themes tab, then press Enter... "
capture "themes-light"

echo ""
echo "=== Dark mode screenshots ==="
read "?Tap the moon button (top-right) to switch to dark mode, then press Enter... "
capture "themes-dark"
read "?Switch to the Gallery tab, then press Enter... "
capture "gallery-dark"
read "?Switch to the Todo tab, then press Enter... "
capture "todo-dark"

echo ""
echo "=== Demo video ==="
VIDEO_PATH="$OUT_DIR/demo.mov"
read "?Press Enter to start recording, then walk through the app by hand... "
xcrun simctl io "$DEVICE_ID" recordVideo "$VIDEO_PATH" &
RECORD_PID=$!
read "?Recording — press Enter when your walkthrough is done... "
kill -INT "$RECORD_PID"
wait "$RECORD_PID" 2>/dev/null || true
echo "Saved docs/media/demo.mov"

if command -v ffmpeg >/dev/null 2>&1; then
  echo ""
  echo "Converting demo.mov to demo.gif..."
  ffmpeg -y -loglevel error -i "$VIDEO_PATH" -vf "fps=12,scale=480:-1" "$OUT_DIR/demo.gif"
  echo "Saved docs/media/demo.gif"
else
  echo ""
  echo "ffmpeg not found — to convert the video to a GIF for the README, run:"
  echo "  ffmpeg -i docs/media/demo.mov -vf \"fps=12,scale=480:-1\" docs/media/demo.gif"
fi

echo ""
echo "Done. docs/media/ now has:"
ls -1 "$OUT_DIR"
