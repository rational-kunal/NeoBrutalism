# T15 — `fontDesign` theme token

**Size:** XS · **Depends on:** T11 (root modifier applies it)

## Goal

Neobrutalism leans on chunky, characterful type, but the theme has zero typography tokens —
text everywhere stays system-default, which dilutes the "one modifier changes everything"
effect. Add the smallest useful token: a `Font.Design` the root modifier applies globally.

## Changes

1. `Sources/NeoBrutalism/Common/Theme.swift`:
   - New stored token on `NBTheme`, following the existing doc-comment style:
     ```swift
     /// The font design applied to the whole hierarchy by the `.neoBrutalism()` root
     /// modifier. `nil` (the default) leaves the system font untouched.
     public private(set) var fontDesign: Font.Design?
     ```
   - Default it to `nil` in `.default` (visual behavior of existing apps must not change).
   - Add `fontDesign: Font.Design?? = nil`? **No** — double-optional is hostile. Follow the
     existing pattern instead: add `fontDesign: Font.Design? = nil` as the **last** parameter
     of `updateBy`, and since "reset to nil" can't be expressed through that signature, also
     accept that limitation — document on `updateBy` that `fontDesign` can only be set, and
     derive-from-`.default` covers reset. (Small, honest trade-off; do not invent a second
     update API for it.)
2. `Sources/NeoBrutalism/Common/NeoBrutalismModifier.swift` — in `NBRootModifier.body`, add
   `.fontDesign(theme.fontDesign)` to the styled chain (`fontDesign(_:)` accepts an optional;
   `nil` is a no-op).
3. `NBTheme` needs `import SwiftUI`'s `Font` — already imported.
4. Preset usage: make the Example app's custom theme use `.rounded`
   (`updateBy(fontDesign: .rounded)`) so the effect is visible somewhere real. T22's presets
   will pick their own.

## Definition of done

- [ ] Kitchen-sink snapshot (`RootModifierTests`) unchanged with the default theme (nil token
      proves no regression), plus one **new** kitchen-sink snapshot with
      `.neoBrutalism(theme: .default.updateBy(fontDesign: .rounded))` showing global rounded
      type.
- [ ] Theming section of README lists the new token.

## Out of scope

Custom font families / `Font` tokens per role (heading/body) — that's a real feature with
Dynamic Type implications; keep it for a dedicated design pass. Font *weight* tokens likewise.
