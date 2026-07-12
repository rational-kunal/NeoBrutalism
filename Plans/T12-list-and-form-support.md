# T12 — List & Form support

**Size:** M · **Depends on:** T11 (docs cross-reference) — implementable independently

## Goal

Real apps are Lists and Forms, and SwiftUI exposes no style protocol for them — the root
modifier can't reach their chrome. Without help, `.neoBrutalism()` apps still show default
grouped-gray lists, which kills the "one modifier" promise. Ship two helpers + docs, plus a
`destructive` theme token so a themed delete affordance reads from the theme instead of a
hardcoded red.

## Theme: `destructive` token

Add a destructive color pair to `NBTheme` (mirrors the `main`/`mainText` pairing), so delete /
danger affordances read from the theme. Additive-only — defaulted `updateBy` params, per
convention #6 (never reorder or change the meaning of existing stored properties).

- `destructive: Color` — the fill for delete/danger affordances. Suggested value (identical
  light/dark, like `main`): `.rgb(1.0, 0.42, 0.42)` (#FF6B6B).
- `destructiveText: Color` — legible foreground on `destructive`; black in both modes to match
  `mainText`'s high-contrast-on-color convention: `.rgb(0.0, 0.0, 0.0)` (black-on-#FF6B6B ≈ 8:1,
  white would fail).

Wire both through `NBTheme.init`, the `.default` literal, and `updateBy(...)` (new defaulted
`Color?` params).

Opportunistic cleanup (only if it stays a small diff): `NBMenu` renders destructive rows with a
hardcoded `Color.red` (`NBMenu.swift:228`) — switch it to `theme.destructive`. If it perturbs the
Menu snapshots, re-record them via the CI workflow; if that balloons the diff, leave it and note
a follow-up.

## New file

`Sources/NeoBrutalism/Components/List/ListModifiers.swift`:

```swift
import SwiftUI

public extension View {
    /// Restyles a `List` or `Form` container: hides the system background so the
    /// theme background shows through, and tightens section spacing.
    ///
    /// Apply to the `List`/`Form` itself. Style each row with ``nbListRow(elevated:)``.
    ///
    /// ```swift
    /// List {
    ///     ForEach(items) { item in
    ///         ItemRow(item).nbListRow()
    ///     }
    /// }
    /// .nbList()
    /// ```
    func nbList() -> some View { … }

    /// Styles one list row as a neobrutalism card: themed surface, thick border,
    /// hidden system separator/background.
    ///
    /// Apply to the row's content view (inside `ForEach`), not to the `List`.
    func nbListRow(elevated: Bool = false) -> some View { … }
}
```

Implementation notes:

- `nbList()` = `.scrollContentBackground(.hidden)` + `.background(theme.background)` +
  `.listRowSpacing(theme.smspacing)` (iOS 17 API) + `.environment(\.defaultMinListRowHeight, …)`
  only if needed — keep minimal.
- `nbListRow(elevated:)` = padding `theme.padding` → background `theme.bw` →
  `.nbBox(elevated: elevated)` → `.listRowBackground(Color.clear)` →
  `.listRowSeparator(.hidden)` → `.listRowInsets(EdgeInsets(top: theme.smspacing/2, leading: theme.padding, bottom: theme.smspacing/2, trailing: theme.padding))`.
  Order matters: the `listRow*` modifiers must be outermost so SwiftUI sees them on the row.
- Both read `@Environment(\.nbTheme)` via a private `ViewModifier` (follow
  `NBBoxModifier`'s shape — public `View` extension + internal modifier struct).
- The helpers touch **appearance only** — selection, `onMove`, and swipe all keep working through
  them untouched. See the swipe note below for how far native styling actually goes.

## Swipe-to-delete: the native ceiling

SwiftUI's native swipe chrome is **not** fully restyleable, so be honest about what this task can
deliver. `.swipeActions` gives exactly two knobs — `.tint(_:)` (the fill) and the button's
`Label` (icon + text). No border stroke, no offset hard shadow, no square corners: the reveal
rectangle's geometry is system-owned. And `ForEach { }.onDelete` gives *zero* control — a fixed
system "Delete" you can't even tint.

So the on-brand baseline this task ships is a **tinted native** swipe, not a fully brutalist one:

- Use explicit `.swipeActions(edge: .trailing)` with a `Button(role: .destructive)` — **not**
  `.onDelete`, so the action can be tinted.
- `.tint(theme.destructive)` + a bold `Label("Delete", systemImage: "trash")`.
- Keep `allowsFullSwipe: true` (default) so swipe-all-the-way-to-delete works, and keep the
  native VoiceOver support that comes with it for free.

State this ceiling plainly in the README/DocC ("native swipe can be tinted, not bordered"). The
fully neobrutalist drag-to-reveal version (border + hard shadow + square corners + press
language) means dropping native swipe for a custom gesture — that's a separate component,
**T31 (`nbSwipeActions`)**, not an appearance helper. Out of scope here.

## Example + tests

- New `ListExampleView` in `Example/Sources/ContentView.swift`: a short `List` whose rows use an
  explicit `.swipeActions` + `.tint(theme.destructive)` delete (per above, wired to mutate the
  backing array so the row actually removes), plus a `Form` section (`Form` is a `List` under the
  hood — same helpers) with a `Toggle`, `LabeledContent`, and `TextField` inside `nbListRow()`
  rows, under `.neoBrutalism()`.
- New snapshot suite `ListTests.swift`: one List with three rows using the helpers (fixed
  height via `.frame(height: 300)`), one Form variant. Record via the CI "Re-record snapshots"
  workflow (committed PNGs never come from a local `record.sh` run — README "Verification"),
  then verify. Capture the resting row, not a mid-swipe state — keep subjects static per
  convention #8.

## Definition of done

- [ ] `destructive` / `destructiveText` tokens added to `NBTheme` (init, `.default`, `updateBy`);
      build green.
- [ ] Helpers documented (DocC comments with the example above), previewed, snapshotted.
- [ ] Example app shows a themed List whose swipe-to-delete works and is tinted with
      `theme.destructive`.
- [ ] README gains a "List & Form" section with the code sample, and states the native-swipe
      ceiling (tint + label only; links the custom `nbSwipeActions` follow-up, T31).

## Out of scope

- The fully neobrutalist custom drag-to-reveal swipe (border/shadow/square corners) —
  **T31 (`nbSwipeActions`)**.
- Styling `List` section headers/footers (document the `.listSectionSeparator`/header font
  combo instead if trivial, else skip); a custom `NBList` container view — helpers first, judge
  demand later.
