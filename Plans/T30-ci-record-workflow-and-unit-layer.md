# T30 — CI re-record workflow + unit-test layer

**Size:** S · **Depends on:** T29 (scripts + direct SnapshotTesting) · Context: [TESTING.md](TESTING.md)

## Part 1 — CI as the recorder of truth

New workflow `.github/workflows/record-snapshots.yml`:

```yaml
name: Re-record snapshots
on:
  workflow_dispatch:   # run from the Actions tab against any branch

permissions:
  contents: write

jobs:
  record:
    runs-on: macOS-15
    timeout-minutes: 20
    steps:
      - uses: actions/checkout@v4
      - name: Select Xcode
        run: |
          source Scripts/snapshot-env.sh
          sudo xcode-select -s "/Applications/${NB_CI_XCODE}.app"
      - name: Record
        run: Scripts/record.sh
      - name: Commit updated references
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add Tests/NeoBrutalismTests/__Snapshots__
          git diff --cached --quiet && echo "No snapshot changes" && exit 0
          git commit -m "Re-record snapshots on pinned CI environment"
          git push
```

Usage becomes: push a PR with visual changes → run this workflow on the branch → review the
committed PNG diffs in the PR → merge. Local recording (`Scripts/record.sh`) remains for fast
iteration, but CI-recorded references are canonical whenever the two disagree.

Note: `Scripts/record.sh` must exit non-zero on build/test *errors* but not on snapshot
mismatches while recording — check SnapshotTesting's record-mode behavior (record runs
typically report failures as "recorded new reference"; the script should tolerate that and
fail only on compile/crash).

## Part 2 — unit-test layer (pixel-free, fully deterministic)

New folder `Tests/NeoBrutalismTests/Unit/`:

1. `BuilderTests.swift` — `NBMenuBuilder`, `NBTabBuilder`, `NBSegmentBuilder`: block
   flattening, `buildOptional(nil)` → `[]`, `buildEither`, `buildArray` (loop) — plain
   `@Test`/`#expect`, `@testable import NeoBrutalism`.
2. `CornerSetTests.swift` — `NBCornerSet` algebra (`.top == [.topLeft, .topRight]`, `.all`
   contains everything) and, via `@testable`, the ControlGroup corner-assignment rule
   (first → `.left`, last → `.right`, middle → `[]`, single → `.all`) — extract that private
   `corners(_:of:)` into an internal function if needed to test it.
3. `APIShapeTests.swift` — a compile-only canary:
   ```swift
   /// Never executed. If this file stops compiling, a public API contract broke.
   @available(*, unavailable)
   @MainActor
   private func publicAPISurface() {
       let _ = NBSlider(value: .constant(CGFloat(0.5)))          // pre-T17 shape must keep compiling
       let _ = NBStepper("Qty", value: .constant(1), in: 0...9)
       let _: NBTheme = .default.updateBy(main: .red)
       // …one line per public initializer/entry point; extend in every API task.
   }
   ```
   (No assertions — the compiler is the test. Keep it in the test target so `@testable` isn't
   needed and only `public` API resolves. Note: with `@available(*, unavailable)` the body
   still type-checks; if the toolchain disagrees, use `if false { }` inside a normal
   function instead — the goal is type-checking without execution.)
4. As T17/T18 land, their specs' pure logic (slider value↔fraction/step snapping, stepper
   clamping) gets unit tests here — those tasks already require extracting the logic.

## Definition of done

- [ ] Workflow run on a scratch branch produces a commit with re-recorded PNGs; a second run
      produces "No snapshot changes".
- [ ] Unit tests pass locally and in CI; deliberately breaking a builder (locally, reverted)
      fails the right test.
- [ ] `CONTRIBUTING.md` (T27) / `Plans/README.md` document the record-via-CI flow in two
      sentences.

## Out of scope

PR-label auto-triggering (nice-to-have; workflow_dispatch is enough); danger-style PR
comments with inline image diffs; coverage thresholds.
