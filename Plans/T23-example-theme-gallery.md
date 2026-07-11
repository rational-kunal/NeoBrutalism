# T23 — Live theme gallery in the Example app

**Size:** S · **Depends on:** T22 (presets)

## Goal

Let a person poking at the Example app *feel* theming: switch between all presets live, in
light and dark, with the whole showcase re-skinning instantly. This screen is also the raw
material for the README hero GIF (T24/T25).

## Changes

All in `Example/Sources/`:

1. New `ThemeGalleryView.swift`:
   - `@State private var selection: ThemeChoice` where `ThemeChoice` is a small local enum
     (`case defaultBlue, sunnyPeach, bubblegum, seafoam, tangerine, lavender`) with `var theme: NBTheme`
     and `var title: String`.
   - Theme picker: use the library's own `NBSegmentedPicker` (or a horizontal `ScrollView` of
     swatch buttons — a filled circle of `theme.main` in an `.nbBox`) — pick whichever reads
     better at six items; swatches recommended.
   - Below the picker, a representative cluster: GroupBox card with text + primary button,
     a Toggle, a TextField, a ProgressView, a Badge row — all styled **only** via
     `.neoBrutalism(theme: selection.theme, applyBackground: true)` on the container.
   - Dark-mode toggle button in the corner (reuse the moon/sun pattern from `ContentView`).
2. Wire it into the app: simplest robust structure — give `ExampleApp`/`ContentView` a
   top-level `NBTabView` (dogfooding) with three tabs: **Gallery** (component showcase),
   **Themes** (this view), **Todo** (existing `TodoAppView`). If `NBTabView` fights the
   scroll layouts, a plain segmented header is fine; note what you chose in the PR.

## Definition of done

- [ ] Switching themes animates cleanly (wrap selection change in
      `withAnimation(.interactiveSpring())`; respect Reduce Motion via the same pattern the
      library uses).
- [ ] Every preset renders correctly in light **and** dark (manual pass).
- [ ] No library changes required — if you hit something that needs a library change, stop
      and report instead of patching the library in this task.
- [ ] Example target builds and runs on the iOS 18 simulator.

## Out of scope

Persisting the chosen theme; editing individual tokens in-app (a "theme editor" is a great
future demo — note it, don't build it).
