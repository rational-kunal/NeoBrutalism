# Testing strategy

**Status:** decided 2026-07-11 · implemented by [T29](T29-snapshot-migration-and-pinning.md) +
[T30](T30-ci-record-workflow.md) · **do these before the Phase 1 tasks**, which all lean on
"snapshots must not change" as their safety net.

## Diagnosis — why the tests feel unreliable

The tests aren't flaky in the usual sense; the comparison is set up to fail:

1. **Unpinned rendering environment.** CI renders on iPhone 16 / iOS 18.0 (Xcode 16.0,
   macOS-15 runner). The development Mac runs Xcode 26.2 where the only simulators with
   devices are **iOS 26.2** (the iOS 18.3/18.5 runtimes are installed but have no devices
   created). Text metrics and antialiasing changed between iOS 18 and 26, so images recorded
   in one environment can never verify in the other. Reference filenames
   (`<test>_<theme>.png`) carry no OS/device tag, so nothing even warns about the mismatch.
2. **Exact-match comparison.** The `swift-snapshot-testing-macros` wrapper (v0.1.6) calls
   pointfree's `.image(size:traits:)` with the default `precision: 1.0` and exposes **no
   precision/perceptualPrecision parameters at all** (verified by reading its
   `assertSnapshot.swift`). A single antialiased pixel fails the test — there is no headroom
   for GPU/runtime noise even within one OS version.
3. **No recording story.** Nothing documents or scripts *where* references must be recorded,
   so they've been recorded wherever a contributor happened to run the tests.

Fixing 1 without 2 stays brittle; fixing 2 without 1 can't absorb cross-OS font changes
(layout shifts exceed any sane tolerance). We do both, plus a CI recording path that makes
the local environment irrelevant for correctness.

## Decision

**Migrate to pointfree `swift-snapshot-testing` directly (already a transitive dependency,
v1.18.4), behind a ~40-line repo-local helper, on one pinned reference environment, with a
CI re-record workflow.** Three tiers:

| Tier | What | Failure mode it kills |
|---|---|---|
| 1. Pinned environment | All snapshot runs target **iPhone 16 · iOS 18.5** — the newest runtime that exists both on the GitHub macos-15 image (Xcode 16.4, its default) and on the dev Mac (runtime already installed). One script is the single source of truth; CI sources the same values. | cross-OS rendering drift |
| 2. Perceptual tolerance | The helper asserts with `precision: 0.995, perceptualPrecision: 0.98` (only possible once we're off the macro wrapper). | antialiasing/GPU noise, cross-Xcode SDK-linking nudges |
| 3. CI as the recorder of truth | A `workflow_dispatch` job re-records all references **on the CI runner itself** and commits them to the branch. Local recording stays possible for iteration, but CI-recorded references are canonical. | "works on my machine" references |

### Options considered and rejected

- **Keep the macro wrapper, just pin the environment** — wrapper is a 0.1.x single-maintainer
  project that hardcodes exact-match precision; pinning alone leaves zero noise headroom and
  we inherit its limits (no tolerance, no per-test record control, no Swift Testing traits).
  The wrapper's only real value was light/dark generation, which is ~10 lines in a helper.
- **Emerge SnapshotPreviews (previews-as-tests)** — attractive dedupe, but our `#Preview`s are
  interactive/animated demos, not stable reference states, and it adds another young
  dependency while we're removing one.
- **ViewInspector for behavior tests** — reflection into SwiftUI internals; breaks on SwiftUI
  updates, i.e. the same instability class we're escaping. Instead: extract logic into plain
  functions and unit-test those.
- **OS-tagged reference filenames (multi-env references)** — doubles review burden and PNG
  churn for zero user value; a single pinned env + tolerance is strictly simpler.

## The test pyramid for this repo

1. **Unit tests** (deterministic, no pixels): builder result-builders
   (`NBMenuBuilder`/`NBTabBuilder`/`NBSegmentBuilder` flattening, `buildEither`/`buildOptional`),
   `NBCornerSet` algebra, ControlGroup corner assignment, and — as T17/T18 land — slider
   value↔fraction math and stepper clamping. Plus one **API-shape file** that merely
   instantiates every public initializer (never executed; a compile-time break detector).
2. **Snapshot tests** (pixels, pinned env): the visual contract. Keep suites lean — one image
   per *visual variant* (type × elevated × on/off × disabled), boundaries plus one midpoint
   for value-driven components (0 / mid / 1 — not four near-identical fills).
3. **Kitchen-sink root-modifier snapshot** (T07/T11): the one test that guards the headline
   feature end-to-end.
4. **Example app build job** (T27): compile-rot detector for everything not snapshot-covered
   (Drawer sheets, NBMenu's overlay window — their *presented* states live outside what
   snapshot rendering can capture; they're covered by previews + the Example app, accepted).

## Determinism policies (enforced in review)

- A snapshot subject must be **static at first frame**: no `onAppear` animations in the
  captured state. Anything animated (skeleton pulse, indeterminate progress) snapshots its
  Reduce-Motion/static rendering — T04 and T20 are already specced this way.
- Snapshot subjects set explicit widths (existing `.sizes(width: .fixed(300))` convention
  carries over as a helper parameter) and use `prettifyForTest()` for padding/background.
- No dates, locales, or system-conditional content in subjects; `LocalizedStringKey` demo
  strings are fine (en-US simulator).
- New/changed reference PNGs must be **eyeballed in the PR** — a wrong reference is worse
  than none. CI's failure artifacts (T27) carry the diff attachments for review.
