# T16 — `nbDialog()` centered modal (alert replacement)

**Size:** M · **Depends on:** T06 recommended (press effect API); reuses NBMenu's overlay
window infrastructure

## Goal

Native `.alert()` cannot be styled, so themed apps get a jarring system alert. Ship a
neobrutalism dialog presented the same way NBMenu presents its dropdown: a dedicated overlay
`UIWindow`, scrim, and stamp-in animation.

## Step 1 — extract the overlay window (refactor, no behavior change)

`NBMenuOverlayWindow` in `Sources/NeoBrutalism/Components/Menu/NBMenu.swift` is generic
already. Move it to `Sources/NeoBrutalism/Common/NBOverlayWindow.swift`, rename to
`NBOverlayWindow`, keep it `internal`, and update NBMenu's references. Run MenuTests to prove
nothing moved visually.

## Step 2 — the dialog

New file `Sources/NeoBrutalism/Components/Dialog.swift`:

```swift
public extension View {
    /// Presents a centered neobrutalism dialog over a scrim — a themed replacement for
    /// `alert(_:isPresented:actions:message:)`.
    ///
    /// ```swift
    /// .nbDialog("Delete spell?", isPresented: $confirming) {
    ///     Button("Delete", role: .destructive) { delete() }
    ///     Button("Keep") { }
    /// } message: {
    ///     Text("This cannot be undone.")
    /// }
    /// ```
    func nbDialog<Actions: View, Message: View>(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions,
        @ViewBuilder message: () -> Message
    ) -> some View
}
```

Behavior spec:

- **Scrim**: full-screen `theme.overlay`, tap dismisses (sets binding false). Content window
  ignores safe area.
- **Card**: `VStack(spacing: theme.spacing)`: bold title, message (`theme.text`), then the
  actions laid out vertically, each full-width. Card = `padding(theme.xlpadding)` →
  `background(theme.bw)` → `.nbBox()` → max width ~320 → centered.
- **Buttons**: consumers pass plain `Button`s. Apply `.buttonStyle(.neoBrutalism())` inside
  the dialog; map `role: .destructive` by… nothing automatic (ButtonStyle can't read role
  pre-iOS 17.4 reliably) — instead document that destructive actions should use
  `.buttonStyle(.neoBrutalism(type: .neutral))` or a red-tinted theme. Keep it simple; note
  the limitation.
- Every action tap must ALSO dismiss (wrap actions:
  `.simultaneousGesture(TapGesture().onEnded { isPresented = false })` is fragile — instead
  intercept via `Button` inside dialog is consumer-owned, so wrap the actions container in
  an environment `\.nbDialogDismiss` closure? **Chosen approach:** document that the consumer
  flips the binding in their action (exactly like SwiftUI's `alert` does automatically —
  but we can't). To soften it, ALSO auto-dismiss via scrim tap and provide a default
  "dismiss on any action tap" using `simultaneousGesture` on the actions container. Verify
  both fire.
- **Animation**: pop in with `nbPopAnimation`, collapse+fade out with `nbPressAnimation`
  (mirror `NBMenuOverlayContent`'s `appear` pattern, including its Reduce Motion handling).
- **Accessibility**: the card gets `.accessibilityAddTraits(.isModal)`; scrim gets
  `.accessibilityLabel("Dismiss")` + `.accessibilityAction { … }`; Escape/VoiceOver-Z
  dismissal via `.onExitCommand` is macOS-only — skip.

## Tests + example

- Snapshot: dialog open state — render `NBDialogCard` (extract the card as an internal view
  so it can be snapshotted without the window machinery) in `DialogTests.swift`.
- Example app `DialogExampleView`: button opens dialog with destructive + cancel actions.

## Definition of done

- [ ] MenuTests pass without re-recording after the Step-1 extraction.
- [ ] Dialog: DocC, preview, snapshot (card), Example entry, README section.
- [ ] Rotation / dynamic type spot-check in the simulator (long title wraps, card never
      exceeds screen).

## Out of scope

`confirmationDialog`-style bottom sheets (that's `nbDrawer`'s job); queueing multiple
dialogs; a `nbDialog(item:)` variant (add later if asked).
