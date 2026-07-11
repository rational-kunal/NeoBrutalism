# T13 — Navigation bar / toolbar helper

**Size:** S · **Depends on:** nothing

## Goal

Under `.neoBrutalism()` the navigation bar still looks stock-iOS (translucent material, system
title). Give apps a one-modifier way to bring the chrome in line, using only per-view SwiftUI
APIs — **no global `UINavigationBarAppearance` mutation** (a library must not restyle screens
it wasn't applied to).

## New file

`Sources/NeoBrutalism/Components/Navigation/NavigationModifiers.swift`:

```swift
public extension View {
    /// Themes the navigation bar for this screen: opaque `theme.background` bar with the
    /// standard border-color divider. Apply inside a `NavigationStack`, on the screen content.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ContentView()
    ///         .navigationTitle("Spells")
    ///         .nbNavigationBar()
    /// }
    /// .neoBrutalism()
    /// ```
    func nbNavigationBar() -> some View { … }
}
```

Implementation (private `ViewModifier` reading `@Environment(\.nbTheme)`):

- `.toolbarBackground(theme.background, for: .navigationBar)`
- `.toolbarBackgroundVisibility(.visible, for: .navigationBar)` (iOS 18 name; on iOS 17 use
  `.toolbarBackground(.visible, for: .navigationBar)` — the iOS 17-compatible spelling is fine
  for both)
- `.toolbarTitleDisplayMode(.inline)` is a caller choice — do **not** set it.

Known limit (state it in the DocC comment): SwiftUI provides no per-screen API for the title
*font*. Large bold titles already fit the style; if a consumer wants a custom title font, the
documented pattern is `.toolbar { ToolbarItem(placement: .principal) { Text("…").bold() } }` —
include that snippet in the comment rather than an appearance hack.

## Example + tests

- Example app: wrap the existing showcase `ScrollView` in a `NavigationStack` with
  `.navigationTitle("NeoBrutalism")` + `.nbNavigationBar()` (or add a dedicated small demo
  screen if wrapping the showcase disturbs existing snapshots/screenshots).
- Snapshot: `NavigationTests.swift` — a `NavigationStack { Text("Content").navigationTitle("Title").nbNavigationBar() }`
  at fixed size. If bar rendering proves unstable across simulators, keep the suite to one
  test and note flakiness findings in the PR.

## Definition of done

- [ ] Modifier shipped with DocC comment + preview; Example app screen shows a themed bar.
- [ ] Toolbar `Button`s inside the demo screen pick up `NBButtonStyle` from the root modifier
      — verify visually; if SwiftUI resets styles inside toolbars (it does in some contexts),
      document `.buttonStyle(.neoBrutalism(type: .neutral))` on the toolbar item as the
      pattern.
- [ ] README "Navigation" snippet added.

## Out of scope

Tab bar (`TabView`) chrome; `NavigationSplitView`; custom back-button styling.
