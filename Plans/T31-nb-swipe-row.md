# T31 — Neobrutalist swipe actions (`nbSwipeActions`)

**Size:** M · **Depends on:** T12 (`destructive` token; ships the tinted-native baseline this
supersedes)

## Goal

Native `.swipeActions` can only be **tinted**, not bordered/shadowed (see T12's "native ceiling"
note), so swipe-to-delete under `.neoBrutalism()` still reveals a flat system rectangle. Ship a
custom drag-to-reveal swipe that renders real neobrutalism action tiles — thick border,
`destructive` fill, square corners, the press language — as a drop-in alternative to
`.swipeActions`.

This is the "custom swipe row" T12 deferred. Adoption is a rename: `.swipeActions` →
`.nbSwipeActions`.

## New file

`Sources/NeoBrutalism/Components/SwipeActions/NBSwipeActions.swift`:

```swift
import SwiftUI

/// One action revealed by ``SwiftUI/View/nbSwipeActions(edge:allowsFullSwipe:actions:)``.
public struct NBSwipeAction: Identifiable {
    public let id = UUID()
    let title: String
    let systemImage: String?
    let role: ButtonRole?          // .destructive fills with theme.destructive
    let tint: Color?               // optional fill override; defaults by role
    let action: () -> Void

    public init(_ title: String, systemImage: String? = nil, role: ButtonRole? = nil,
                tint: Color? = nil, action: @escaping () -> Void) { … }
}

public extension View {
    /// Reveals neobrutalist action tiles when the row is dragged from `edge` — a themed,
    /// bordered alternative to SwiftUI's `.swipeActions`, which only lets you tint the fill.
    ///
    /// Intended for rows in a `LazyVStack`/`ScrollView`. **Not** `List`: List owns its own pan
    /// gesture and fights a custom one — use native `.swipeActions` + `.tint(theme.destructive)`
    /// there (see T12).
    ///
    /// ```swift
    /// ItemRow(item)
    ///     .nbListRow()
    ///     .nbSwipeActions(actions: [
    ///         NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {
    ///             delete(item)
    ///         }
    ///     ])
    /// ```
    func nbSwipeActions(
        edge: HorizontalEdge = .trailing,
        allowsFullSwipe: Bool = true,
        actions: [NBSwipeAction]
    ) -> some View { … }
}
```

Optional polish (not required for v1): add a `@resultBuilder` overload so callers can write
`.nbSwipeActions { NBSwipeAction(…) }` without the array brackets. Ship the array form first.

## Implementation notes

- **Gesture.** A `DragGesture` drives `@State private var offset`. Snap points: closed (0) and
  open (−totalActionsWidth for `.trailing`). Below a small threshold snap back; past it snap open.
  Past a full-swipe threshold (≈ 60% of row width) with `allowsFullSwipe`, run the **first**
  action (the destructive one) directly and animate the row out.
- **Tiles.** Each action = icon/`Label` + `.padding(theme.padding)`, full row height, filled with
  its resolved color (`role == .destructive` → `theme.destructive`, foreground
  `theme.destructiveText`; else `tint ?? theme.main` with `theme.mainText`), `theme.border` stroke
  at `theme.borderWidth`, square inner corners (they butt against the row edge). Box language but
  flush — no offset shadow on the revealed tiles.
- **Animation.** Snap open/closed with `nbPressAnimation` / `nbPopAnimation`; instant under
  `accessibilityReduceMotion` (convention #3).
- **Accessibility (the reason this is a real task, not a demo).** Native swipe exposes its actions
  to VoiceOver for free; a custom drag does not. Add `.accessibilityAction(named:)` for every
  action so assistive-tech users can trigger them without dragging, and keep the row's own
  label/traits intact.
- Read `@Environment(\.nbTheme)` via a private `ViewModifier` (follow `NBBoxModifier`'s shape).

## Example + tests

- Example app: a `LazyVStack` of `nbListRow()` cards, each with `.nbSwipeActions(...)` deleting
  from the backing array; include a two-action row (e.g. a neutral "Pin" + destructive "Delete")
  to exercise multi-tile layout. Place it next to T12's native-swipe List so the difference —
  bordered tiles vs. tinted system rectangle — is obvious.
- Snapshot suite `SwipeActionsTests.swift`: render a row in its **revealed** state (seed the open
  offset via an internal test hook / initial state — no `onAppear` animation, per convention #8),
  light + dark; plus a two-action variant. Record via the CI "Re-record snapshots" workflow
  (README "Verification"), then verify.

## Definition of done

- [ ] `NBSwipeAction` + `.nbSwipeActions(...)` shipped with DocC (example above) + preview.
- [ ] Revealed tiles use `theme.destructive` / `theme.border` / `theme.destructiveText` — no
      hardcoded colors.
- [ ] Full-swipe triggers the destructive action; snap open/close respects Reduce Motion.
- [ ] Every action is reachable via VoiceOver (`.accessibilityAction(named:)`), verified.
- [ ] Snapshot suite (revealed state, light + dark) recorded via the CI workflow; Example app
      screen added.
- [ ] README/DocC cross-links T12: native = tint-only, `nbSwipeActions` = full look, List caveat.

## Out of scope

- Using `nbSwipeActions` **inside a `List`** — List's own pan gesture makes it unreliable;
  document native `.swipeActions` as the List answer. Revisit only if demand appears.
- Leading + trailing actions simultaneously; per-tile full-swipe customization.
- Cross-row "only one open at a time" coordination — each row owns its open state in v1; a shared
  coordinator (PreferenceKey up, id down) is a follow-up if the single-open UX is wanted.
