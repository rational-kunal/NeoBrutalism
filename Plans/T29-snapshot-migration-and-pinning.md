# T29 — Snapshot stack migration + environment pinning

**Size:** M · **Depends on:** nothing · **Blocks:** every task that says "snapshots must not
change" (all of Phase 1+) — do this first. Context: [TESTING.md](TESTING.md).

## Goal

Replace the `swift-snapshot-testing-macros` wrapper with pointfree `swift-snapshot-testing`
(already resolved at 1.18.4 as a transitive dep) behind a small repo-local helper; pin every
snapshot run to **iPhone 16 · iOS 18.5**; re-record all references once on that pin.

## Step 1 — dependency swap

`Package.swift`: remove the `swift-snapshot-testing-macros` package; add
`.package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.4")`;
test target depends on `.product(name: "SnapshotTesting", package: "swift-snapshot-testing")`.

## Step 2 — the helper

Extend `Tests/NeoBrutalismTests/SnapshotHelper.swift` (keep `prettifyForTest()`):

```swift
import SnapshotTesting
import SwiftUI

/// Asserts light- and dark-mode snapshots of `view` at a fixed width with the repo's
/// standard tolerance. References land in `__Snapshots__/<TestFile>/<test>-{light|dark}.png`.
@MainActor
func assertNBSnapshot(
    of view: some View,
    width: CGFloat = 300,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
) {
    let subject = view.prettifyForTest().frame(width: width)
    for (variant, style) in [("light", UIUserInterfaceStyle.light), ("dark", .dark)] {
        assertSnapshot(
            of: subject,
            as: .image(
                precision: 0.995,
                perceptualPrecision: 0.98,
                layout: .sizeThatFits,
                traits: UITraitCollection(userInterfaceStyle: style)
            ),
            named: variant,
            fileID: fileID, file: filePath, testName: testName, line: line, column: column
        )
    }
}
```

Adjust to the exact `Snapshotting.image` signature in SnapshotTesting 1.18 for SwiftUI views
(`image(precision:perceptualPrecision:layout:traits:)`) — if the trait-based dark mode
doesn't take effect with `.sizeThatFits` on this version, fall back to
`.environment(\.colorScheme, .dark)` on the subject and note it in the PR.

## Step 3 — mechanical suite migration

For each of the ~19 test files: `@Suite @SnapshotSuite @MainActor struct XTests` with
`@SnapshotTest(.sizes(width: .fixed(300)))` funcs **returning** views becomes:

```swift
@Suite(.snapshots(record: .missing)) @MainActor
struct GaugeTests {
    @Test func gauge_mid() {
        assertNBSnapshot(
            of: Gauge(value: 0.52) { Text("Half") }.gaugeStyle(.neoBrutalism)
        )
    }
}
```

While migrating, apply the slimming policy from TESTING.md: value-driven components keep
boundaries + one midpoint (e.g. Gauge 0 / 0.52 / 1.0 — drop 0.2; same for Progress, Slider).
Delete **all** existing `__Snapshots__` PNGs (they were recorded on unpinned environments and
the naming scheme changes anyway).

## Step 4 — pin the environment

1. New `Scripts/snapshot-env.sh` — single source of truth:
   ```zsh
   # Reference environment for all snapshot rendering. Change ONLY via a PR that
   # also re-records every image (Scripts/record.sh).
   export NB_SNAPSHOT_DEVICE="iPhone 16"
   export NB_SNAPSHOT_OS="18.5"
   export NB_CI_XCODE="Xcode_16.4"   # GH macos-15 image default; ships iOS 18.5 sims
   ```
2. `Scripts/test.sh`: sources the env file, creates the simulator if missing
   (`xcrun simctl create "$NB_SNAPSHOT_DEVICE" ... iOS-18-5` — the runtime is already
   installed on the dev Mac; if absent print the `xcodebuild -downloadPlatform iOS`
   instruction and exit), then runs
   `xcodebuild -scheme NeoBrutalism -destination "platform=iOS Simulator,name=$NB_SNAPSHOT_DEVICE,OS=$NB_SNAPSHOT_OS" test`.
3. `Scripts/record.sh`: same but prefixes `TEST_RUNNER_SNAPSHOT_TESTING_RECORD=all` (the
   `TEST_RUNNER_` prefix forwards the variable into the test process, where SnapshotTesting
   reads `SNAPSHOT_TESTING_RECORD`). Verify the forwarding works; if not, temporarily set
   `record: .all` in the suite trait instead and fix the script before merging.
4. `.github/workflows/ci.yml`: `DEVELOPER_DIR` → `$NB_CI_XCODE`, destination →
   `OS=18.5,name=iPhone 16` (read from the env file in a step so the values can't fork).

## Step 5 — re-record + review

Run `Scripts/record.sh`, then `Scripts/test.sh` twice (green + stable). Eyeball every PNG
pair — this is the new visual baseline for the whole library, so review it like a design PR,
not a test PR.

## Definition of done

- [ ] `swift-snapshot-testing-macros` gone from `Package.resolved`.
- [ ] `Scripts/test.sh` green twice in a row locally **and** CI green on the same commit —
      the definition of "reliable" this task exists for.
- [ ] A deliberate 1-pixel-ish change (e.g. bump a padding by 0.5) fails the test — proves
      tolerance isn't so loose it's blind.
- [ ] `Plans/README.md` Verification section updated to point at the scripts.
- [ ] PR description lists image count before/after slimming.

## Out of scope

The CI re-record workflow (T30); unit-test layer (T30); changing what any component renders.
