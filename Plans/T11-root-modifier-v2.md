# T11 — Root modifier v2: full coverage, one signature

**Size:** M · **Depends on:** T09 (label styles safe), T10 (final names). T07's
`RootModifierTests` guards this work.

## Goal

`.neoBrutalism()` is the headline feature: every style the library ships should apply from the
single root call, and the API should be one function, not three overloads.

File: `Sources/NeoBrutalism/Common/NeoBrutalismModifier.swift`.

## Changes

1. **Complete the style list** in `NBRootModifier.body`:
   ```swift
   content
       .buttonStyle(.neoBrutalism())
       .toggleStyle(.neoBrutalism)              // switch — native Toggle semantics (T10 decision)
       .textFieldStyle(.neoBrutalism)
       .progressViewStyle(.neoBrutalism)
       .gaugeStyle(.neoBrutalism)               // new
       .labelStyle(.neoBrutalism)               // new — safe after T09 (inherits foreground)
       .labeledContentStyle(.neoBrutalism)      // new
       .menuStyle(.neoBrutalism)                // new (styles the trigger; dropdown stays native)
       .disclosureGroupStyle(.neoBrutalism)
       .controlGroupStyle(.neoBrutalism)
       .groupBoxStyle(.neoBrutalism())
       .environment(\.nbTheme, theme)
   ```
   Note the toggle default changes from checkbox → **switch**: a restyled native `Toggle`
   should stay a switch. Checkbox remains one modifier away
   (`.toggleStyle(.neoBrutalismCheckbox)` on any subtree). Call this out in the DocC comment.

2. **Collapse the three public overloads into one** (source-compatible with every existing
   call site — verify each current overload's call shape still resolves):
   ```swift
   public extension View {
       /// Applies the NeoBrutalism theme and every default component style to this view tree.
       /// - Parameters:
       ///   - theme: The ``NBTheme`` to inject. Defaults to ``NBTheme/default``.
       ///   - applyBackground: When `true`, also fills the safe-area-ignoring background
       ///     with `theme.background`, so a two-line app is fully styled.
       func neoBrutalism(theme: NBTheme = .default, applyBackground: Bool = false) -> some View {
           modifier(NBRootModifier(theme: theme, applyBackground: applyBackground))
       }
   }
   ```
   Delete the two now-redundant overloads (identical behavior, so this is not a break).

3. **DocC comment** on the function must list exactly which protocols are styled and the two
   deliberate omissions:
   - toggle default is the switch (checkbox/radio opt-in per subtree),
   - `List`/`Form`/navigation aren't stylable via environment — point to the T12/T13 helpers.

4. **Update the kitchen-sink assets**: extend `RootModifierTests` (from T07) and the Example
   app's `RootModifierExampleView` with `Gauge`, `Label`, `LabeledContent`, `Menu`, and a
   `ControlGroup` so the contract test actually covers the new lines. Re-record that suite
   (the Toggle in it changes from checkbox to switch — expected diff; eyeball it).

## Definition of done

- [ ] Kitchen-sink snapshot shows every listed control styled with zero per-view modifiers.
- [ ] All other suites pass without re-recording.
- [ ] README "How to use" section shows the one-liner + `applyBackground: true` two-liner.
- [ ] Deprecation warnings: none (call sites of the old overloads keep compiling because the
      new signature subsumes them — confirm `Example/` builds).

## Out of scope

List/Form/navigation styling (T12/T13); a `fontDesign` token (T15); making `NBMenu` the
`Menu` replacement (SwiftUI gives us no hook — the dropdown stays native by design).
