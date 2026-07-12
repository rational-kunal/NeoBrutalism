# NeoBrutalism — Execution Plans

This folder turns [ROADMAP.md](../ROADMAP.md) into implementation-ready tasks. Each `Txx-*.md`
file is scoped to **one focused coding session** (small diff, one concern, verifiable), so it can
be handed to a coding agent as-is.

## How to run a task

Prompt template for a coding session:

> Read `Plans/README.md` (conventions + verification), then implement `Plans/Txx-<name>.md`
> exactly as specified. Stay inside the task's "Out of scope" boundary. When done, run the
> verification steps and report results.

Recommended order is the numeric order. Dependencies are noted per task; anything without a
dependency note can run in any order within its phase.

**Running independent tasks in parallel (2026-07-12):** tasks without a dependency note on each
other can be farmed out to parallel coding-agent sessions, one per task. If your agent runner's
isolated-worktree mechanism doesn't guarantee the new worktree branches from the current repo
checkout (ours didn't — it silently based all 4 parallel worktrees on a stale/divergent `main`
snapshot that predated T01–T04 and even T29's snapshot-stack migration, instead of the
`feature/revamp` tip they were meant to build on), don't push an agent's branch as-is. Diff it
against the real target base first (`git diff <target>...<agent-branch> --stat`); if the base
has moved, rebase the agent's own commit(s) onto the real tip (excluding whatever unrelated
commits came along for the ride) and hand-resolve any overlap before opening the PR. T05 and T06
both had real conflicts this way — T05 vs. T03's disabled-state work, T06 vs. an
already-existing `NBCornerSet` the agent had no way to see and duplicated. T07's stale base
predated the root modifier, GroupBox styling, and even T29's `assertNBSnapshot` helper entirely,
so its output used the wrong test macros and dropped `.neoBrutalism()`/`GroupBox` from its own
contract test — that one needed a full rewrite against the real current APIs rather than a rebase.

**CI-recording gotchas found this round (2026-07-12):** (1) `Scripts/record.sh` sets
`SNAPSHOT_TESTING_RECORD=all`, so the "Re-record snapshots" workflow re-records *every* suite,
not just the ones your PR touched — that's fine, it only commits files that actually changed.
(2) If a task renames a `@Test func`, the recorded reference filename (`<test>.<light|dark>.png`)
is keyed off the *old* function name via `#function` — renaming the test without `git mv`-ing its
PNGs breaks every renamed test (T08 hit this: renamed `checbox_*` → `checkbox_*` per its own
"zero `checbox` hits in Tests/" acceptance criterion, forgot the reference files, all 9 Checkbox
tests failed on CI until fixed). (3) `progress_indeterminate` failed once on an unrelated PR
(T06, which never touches Progress/Gauge) and passed cleanly on a re-run and on two other PRs —
treat a single indeterminate-progress snapshot failure as a flake to retry, not a regression,
unless it repeats. (4) When the "Re-record snapshots" workflow's own commit (authored by
`github-actions[bot]`) retriggers the PR's `pull_request` check, that new run can land in
`action_required` pending manual approval in the Actions tab — a repo-owner action, not something
a coding agent should (or, per this session, even technically could) approve on its own.

## Phase 0 — before any task runs (maintainer, by hand)

- [ ] Commit the current working tree (it builds: `BUILD SUCCEEDED` on 2026-07-11). It contains
      the new Gauge/Label/LabeledContent/ControlGroup/Menu/SegmentedPicker/Stepper/TabView work,
      the `.neoBrutalism()` root modifier, and the Tabs/Card/FlatCard deletions.
- [ ] Prune stale agent worktrees: `git worktree list` shows ~10 under `.claude/worktrees/`;
      remove with `git worktree remove <path>` + delete their branches once confirmed merged/abandoned.
- [ ] Run the full snapshot suite once locally so every task starts from green.

## The target (recap)

One modifier at the root restyles a plain SwiftUI app:

```swift
WindowGroup {
    ContentView()          // plain SwiftUI: Button, Toggle, TextField, List, GroupBox…
        .neoBrutalism()    // ← the whole app takes the neobrutalism look
}
```

SwiftUI makes this possible because style modifiers (`buttonStyle`, `toggleStyle`, …) propagate
through the environment to every descendant. The root modifier exists
([NeoBrutalismModifier.swift](../Sources/NeoBrutalism/Common/NeoBrutalismModifier.swift)); the
work is finishing coverage, fixing consistency, and covering the views SwiftUI does **not** let
us style (List, navigation, dialogs) with helpers or drop-in `NB*` views.

## SwiftUI coverage map

| Native view | Style protocol? | Our answer | Status |
|---|---|---|---|
| Button | `ButtonStyle` | `.neoBrutalism(type:variant:)` | ✅ needs disabled state (T03) |
| Toggle | `ToggleStyle` | checkbox / switch / radio styles | ✅ needs disabled + naming (T03, T10) |
| TextField / SecureField | `TextFieldStyle` | `.neoBrutalism` | ✅ verify SecureField (T14) |
| TextEditor | none usable | `nbTextEditor()` helper | ✅ T14 done |
| ProgressView | `ProgressViewStyle` | `.neoBrutalism` | ✅ indeterminate missing (T04) |
| Gauge | `GaugeStyle` | `.neoBrutalism` | ✅ dedupe with Progress (T04) |
| Label | `LabelStyle` | `.neoBrutalism` | ✅ foreground fix (T09) |
| LabeledContent | `LabeledContentStyle` | `.neoBrutalism` | ✅ contrast fix (T09) |
| DisclosureGroup | `DisclosureGroupStyle` | `.neoBrutalismAccordion` | ✅ naming (T10) |
| GroupBox | `GroupBoxStyle` | `.neoBrutalism(type:elevated:)` | ✅ |
| ControlGroup | `ControlGroupStyle` | `.neoBrutalism` | ✅ press effect (T06) |
| Menu | `MenuStyle` (trigger only) | style + `NBMenu` for the dropdown | ✅ T19 done (dividers/disabled/scroll) |
| Slider | **no protocol** | `NBSlider` | ⚠️ not drop-in yet (T17) |
| Stepper | **no protocol** | `NBStepper` | ✅ T18 done (step/auto-repeat/a11y; Int by design) |
| Picker (segmented) | **no protocol** | `NBSegmentedPicker` | ✅ |
| Picker (menu/wheel) | **no protocol** | document `NBMenu` as the alternative | 🔲 T26 docs |
| List / Form | **not stylable** | `nbList()` / `nbListRow()` helpers | ✅ T12 done |
| Swipe actions (row) | tint + label only | native tint (T12) / `nbSwipeActions` custom reveal (T31) | ✅ T12 native tint done · 🔲 T31 custom reveal |
| NavigationStack chrome | partial | `nbNavigationBar()` helper | ✅ T13 done |
| TabView (screen-level) | **not stylable** | `NBTabView` (inline tabs) | ✅ |
| alert / confirmationDialog | **not stylable** | `nbDialog()` | ✅ T16 done |
| sheet | partial | `nbDrawer()` | ✅ |
| Radio group (no native iOS control) | — | `NBRadioGroup` | ✅ structure + a11y fixed (T05) |

Intentionally custom-only (no native counterpart): `NBAlert`, `NBBadge`, `NBCollapsable`,
skeletons.

## Task index

**Phase T — Testing foundation** (do before everything else: Phase 1 tasks all use
"snapshots must not change" as their safety net, which requires snapshots you can trust.
Diagnosis + strategy: [TESTING.md](TESTING.md))

| Task | Title | Size | Status |
|---|---|---|---|
| [T29](T29-snapshot-migration-and-pinning.md) | Snapshot stack migration + environment pinning (iPhone 16 · iOS 18.5) | M | ✅ Done |
| [T30](T30-ci-record-workflow-and-unit-layer.md) | CI re-record workflow + unit-test layer | S | ✅ Done |

**Phase 1 — Correctness & consistency** (small mechanical fixes)

| Task | Title | Size | Status |
|---|---|---|---|
| [T01](T01-theme-token-color-sweep.md) | Replace hardcoded blacks with theme tokens | XS | ✅ Done |
| [T02](T02-reduce-motion-sweep.md) | Respect Reduce Motion everywhere | XS | ✅ Done |
| [T03](T03-disabled-states.md) | Disabled-state rendering for all controls | S | ✅ Done |
| [T04](T04-bar-meter-dedupe-indeterminate.md) | Shared bar meter for Progress+Gauge; indeterminate progress | S | ✅ Done |
| [T05](T05-radio-structure-a11y.md) | Radio: remove nested button, add accessibility | S | ✅ Done ([PR #24](https://github.com/rational-kunal/NeoBrutalism/pull/24)) |
| [T06](T06-press-effect-unification.md) | One shared press effect everywhere | S | ✅ Done ([PR #25](https://github.com/rational-kunal/NeoBrutalism/pull/25)) |
| [T07](T07-snapshot-coverage-gaps.md) | Snapshot tests for Accordion/Alert/Badge/Collapsable | S | ✅ Done ([PR #27](https://github.com/rational-kunal/NeoBrutalism/pull/27)) |
| [T08](T08-dead-code-and-typos.md) | Dead code, folder typos, namespace cleanup | XS | ✅ Done ([PR #26](https://github.com/rational-kunal/NeoBrutalism/pull/26)) |

**Phase 2 — The one-modifier headline**

| Task | Title | Size | Status |
|---|---|---|---|
| [T09](T09-label-labeledcontent-hygiene.md) | Label/LabeledContent style fixes (prereq for T11) | XS | ✅ Done |
| [T10](T10-style-naming-convention.md) | Naming convention: `.neoBrutalism` everywhere, deprecations | S | ✅ Done ([PR #32](https://github.com/rational-kunal/NeoBrutalism/pull/32)) |
| [T11](T11-root-modifier-v2.md) | Root modifier v2: full coverage, one signature | M | ✅ Done ([PR #33](https://github.com/rational-kunal/NeoBrutalism/pull/33)) |
| [T12](T12-list-and-form-support.md) | List & Form support (`nbList`, `nbListRow`) | M | ✅ Done ([PR #35](https://github.com/rational-kunal/NeoBrutalism/pull/35)) |
| [T13](T13-navigation-chrome.md) | Navigation bar/toolbar helper | S | ✅ Done ([PR #30](https://github.com/rational-kunal/NeoBrutalism/pull/30)) |
| [T14](T14-texteditor-securefield.md) | TextEditor helper + SecureField verification | S | ✅ Done ([PR #29](https://github.com/rational-kunal/NeoBrutalism/pull/29)) |
| [T15](T15-typography-token.md) | `fontDesign` theme token | XS | ✅ Done ([PR #34](https://github.com/rational-kunal/NeoBrutalism/pull/34)) |
| [T16](T16-dialog.md) | `nbDialog()` centered modal (alert replacement) | M | ✅ Done ([PR #31](https://github.com/rational-kunal/NeoBrutalism/pull/31)) |

**Phase 3 — Drop-in parity for custom components** (6/6 done)

| Task | Title | Size | Status |
|---|---|---|---|
| [T17](T17-slider-v2.md) | NBSlider v2: generic value, range, step, a11y | M | ✅ Done ([PR #40](https://github.com/rational-kunal/NeoBrutalism/pull/40)) |
| [T18](T18-stepper-v2.md) | NBStepper v2: step, auto-repeat, a11y | S | ✅ Done ([PR #36](https://github.com/rational-kunal/NeoBrutalism/pull/36)) |
| [T19](T19-menu-polish.md) | NBMenu: dividers, disabled items, long menus | S | ✅ Done ([PR #37](https://github.com/rational-kunal/NeoBrutalism/pull/37)) |
| [T20](T20-skeleton-shimmer.md) | Skeleton pulse + `nbSkeleton()` modifier | S | ✅ Done ([PR #39](https://github.com/rational-kunal/NeoBrutalism/pull/39)) |
| [T21](T21-alert-conveniences.md) | NBAlert string-based initializers | XS | ✅ Done ([PR #38](https://github.com/rational-kunal/NeoBrutalism/pull/38)) |
| [T31](T31-nb-swipe-row.md) | Neobrutalist swipe actions (`nbSwipeActions`) — full drag-to-reveal look (depends on T12) | M | ✅ Done ([PR #41](https://github.com/rational-kunal/NeoBrutalism/pull/41)) |

**Phase 4 — Theming as a feature**

| Task | Title | Size |
|---|---|---|
| [T22](T22-preset-themes.md) | Ship 5 preset themes | S |
| [T23](T23-example-theme-gallery.md) | Live theme gallery in the Example app | S |

**Phase 5 — Adoption** (parallel to everything after Phase 2)

| Task | Title | Size |
|---|---|---|
| [T24](T24-example-app-restructure.md) | Example app: real-app-first + capture kit | M |
| [T25](T25-readme-overhaul.md) | README overhaul: hero, 10-second pitch | S |
| [T26](T26-docc-and-spi.md) | DocC catalog + Swift Package Index | M |
| [T27](T27-release-engineering.md) | CHANGELOG, CONTRIBUTING, CI artifacts, v2.1 | S |
| [T28](T28-launch-kit.md) | Launch kit: posts, submissions, link-backs | S |

## Conventions (the contract for every task)

1. **Native first.** Style native controls via style protocols; custom `NB*` views only when no
   protocol exists. Custom views mirror the native initializer shape so adoption is a rename.
2. **Theme tokens only.** No hardcoded colors/sizes in component bodies — read
   `@Environment(\.nbTheme)`. Every border is `theme.border`, every surface `theme.bw` or
   `theme.main`, every radius `theme.borderRadius`.
3. **Box + press language.** Bordered surfaces go through `.nbBox(elevated:roundedCorners:)`.
   Pressed = shadow collapses (`nbPressEffect` / `nbPressAnimation`). Pop-in = `nbPopAnimation`.
4. **Accessibility.** Custom-gesture components need labels/values/traits and
   `accessibilityReduceMotion` handling. Native-styled controls inherit this for free — don't
   break it (keep `Button`-based internals, not bare `onTapGesture`, where practical).
5. **Definition of done** for anything public: DocC comment `///` with a code example ·
   `#Preview(traits: .modifier(NBPreviewHelper()))` · snapshot test(s) (light+dark are generated
   by the suite) · Example app entry (`Example/Sources/ContentView.swift`) · README section.
6. **API stability.** Additive changes only until v3.0. Renames = add new name +
   `@available(*, deprecated, renamed:)` on the old one. Never change `NBTheme`'s stored
   properties' meaning; adding tokens with defaulted `updateBy` parameters is fine.
7. **Code style.** Match the existing files: 4-space indent, `// MARK: -` sections, private
   helpers in an `extension` below the type, previews at the bottom of the file.
8. **Snapshot determinism.** Snapshot subjects must be static at first frame — no `onAppear`
   animations in the captured state; animated things snapshot their Reduce-Motion/static
   rendering. Full policy in [TESTING.md](TESTING.md).
9. **Stay brutalist.** Flat fills, thick borders, hard offset shadows, square-ish corners.
   No gradients, no blur or translucent materials, no soft/diffuse shadows, no glossy
   highlights. When a native affordance's chrome can't be made brutalist (system-owned
   geometry — e.g. native swipe reveal, nav-bar material), tint/configure what the API exposes,
   state the ceiling in the docs, and spec a custom `NB*` alternative as its own task rather
   than shipping an off-brand compromise (the T12 → T31 pattern).

## Verification (run after every task)

```bash
# Build (fast sanity check — the package is iOS-only, so plain `swift build` won't work):
xcodebuild -scheme NeoBrutalism -destination "generic/platform=iOS Simulator" build

# Snapshot tests — MUST run on the pinned reference environment (see TESTING.md):
Scripts/test.sh          # pins iPhone 16 · iOS 26.2, boots/creates the sim if needed
Scripts/record.sh        # local preview of visual changes — committed PNGs come from CI (below)
```

Reference images live in `Tests/NeoBrutalismTests/__Snapshots__/<Suite>/<test>.{light|dark}.png`.

**Recording rule (2026-07-12): every committed reference PNG is recorded by CI, not locally.**
Because of the local ≠ CI gap below, PNGs recorded by a local `Scripts/record.sh` run will fail
on CI (and vice versa) — do not commit them. The one canonical recorder is the
[Re-record snapshots](../.github/workflows/record-snapshots.yml) workflow: push your branch/PR,
then Actions tab → "Re-record snapshots" → Run workflow against that branch. It records on the
pinned environment and pushes the updated PNGs straight to the branch, so they show up in the
PR diff for review. Local record/test remains useful to iterate fast and eyeball what changed —
treat it as a preview, never as the verdict or the source of committed references.

- New snapshot test → commit the test (no PNGs), push, run the re-record workflow, then let the
  PR's normal test run confirm it's stable.
- Intentional visual change → same flow; eyeball every changed PNG (and the Example app) in the
  PR diff before merging.
- Never blanket-delete `__Snapshots__` (T29's one-time exception aside — see
  [T29](T29-snapshot-migration-and-pinning.md)).

**2026-07 repin:** the reference environment moved from iPhone 16 · iOS 18.5 to iPhone 16 ·
iOS 26.2 (`Scripts/snapshot-env.sh`) — Xcode 16.4/iOS 18.5 is no longer installable on the dev
fleet, and GitHub's `macos-15` runner ships Xcode 26.2 (build 17C52) by default, so CI needed no
extra runtime download. All 160 references were re-recorded on the new pin; only 8 (font-metric
drift of a few px, no visual regression) actually changed.

**Known gap — local ≠ CI even on the pin (as of 2026-07-11):** a clean `Scripts/test.sh` run,
with zero source changes, still fails ~116 assertions across unrelated suites (Button, GroupBox,
TabView, Menu, Input, LabeledContent, …) with a consistent **+4pt frame-height** delta between
the freshly-rendered image and the committed reference. This reproduces on an unmodified
checkout, so it is not caused by whatever task you're working on. Suspected cause: the local
simulator *runtime* can patch-update independently of the Xcode/OS version string the pin
targets (`Scripts/snapshot-env.sh` says iOS 26.2, but the exact runtime build — `23C54` at time
of writing — isn't pinned), shifting text/line-height metrics slightly from whatever build the
references were recorded on. **If you're an agent working a task from this folder: a local
snapshot failure is not evidence your change is wrong.** Before concluding a regression: (1)
confirm the same test fails on an unmodified checkout (`git stash` and rerun) — if it does, it's
this gap, not you; (2) prefer CI's result (push a PR, or the "Re-record snapshots" workflow) as
the actual verdict. Only treat a local diff as real if it appears *exclusively* on your changed
files/views and disappears on the unmodified tree.
