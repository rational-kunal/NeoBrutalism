# T12 — List & Form support

**Size:** M · **Depends on:** T11 (docs cross-reference) — implementable independently

## Goal

Real apps are Lists and Forms, and SwiftUI exposes no style protocol for them — the root
modifier can't reach their chrome. Without help, `.neoBrutalism()` apps still show default
grouped-gray lists, which kills the "one modifier" promise. Ship two helpers + docs.

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
- Swipe actions, `onDelete`, selection etc. must keep working — the helpers only touch
  appearance. Verify in the Example app with an `.onDelete`-enabled list.

## Example + tests

- New `ListExampleView` in `Example/Sources/ContentView.swift`: a short `List` with
  `.onDelete`, plus a `Form` section (`Form` is a `List` under the hood — same helpers) with a
  `Toggle`, `LabeledContent`, and `TextField` inside `nbListRow()` rows, under `.neoBrutalism()`.
- New snapshot suite `ListTests.swift`: one List with three rows using the helpers (fixed
  height via `.frame(height: 300)`), one Form variant. Record + verify.

## Definition of done

- [ ] Helpers documented (DocC comments with the example above), previewed, snapshotted.
- [ ] Example app shows a themed List whose swipe-to-delete still works.
- [ ] README gains a "List & Form" section with the code sample.

## Out of scope

Styling `List` section headers/footers (document the `.listSectionSeparator`/header font
combo instead if trivial, else skip); a custom `NBList` container view — helpers first, judge
demand later.
