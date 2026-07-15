# Theming

Every component reads its colors and metrics from one ``NBTheme`` value — override it, derive
from it, or pick one of five bundled presets.

## Overview

NeoBrutalism themes every component through a single ``NBTheme`` value, injected via
`@Environment` by ``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` at the root of your
hierarchy. Components never hardcode colors, spacing, or border metrics — they all read
`@Environment(\.nbTheme)`.

```swift
ContentView()
    .neoBrutalism(theme: .bubblegum, applyBackground: true)
```

Override the theme for a subtree directly with ``SwiftUICore/View/nbTheme(_:)``, independent of
the root modifier:

```swift
struct ContentView: View {
    var theme = NBTheme.default.updateBy(background: .black, mainText: .white)

    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()
            Toggle(isOn: .constant(true)) { Text("Are you a wizard?") }
                .toggleStyle(.neoBrutalismCheckbox)
        }
        .nbTheme(theme)
    }
}
```

## Tokens

`NBTheme` groups its tokens into colors, spacing/sizing, borders, shadow, and typography. See
``NBTheme`` for the full reference on each property; the summary:

### Colors

| Token | Controls |
|---|---|
| `main` | The brand/accent fill for emphasised elements — primary buttons, active states. |
| `bw` | The base surface for bordered elements (cards, inputs, buttons): white in light mode, near-black in dark mode. |
| `overlay` | The scrim behind modals, sheets, and dialogs. |
| `background` | The page/screen background, distinct from `bw` so bordered elements stand out. |
| `blank` | A plain white kept constant regardless of light/dark mode (e.g. content sitting on `main`). |
| `border` | The thick outline color — black in both modes, by design (see below). |
| `text` | The default foreground for body text and icons. |
| `mainText` | Foreground for text/icons placed on top of `main`, kept legible regardless of theme. |
| `destructive` | The fill for delete/danger affordances (destructive menu rows, swipe-to-delete tiles). |
| `destructiveText` | Foreground for text/icons placed on top of `destructive`. |
| `clear` | Fully transparent, for when a token slot is required but nothing should paint. |

### Spacing & sizing

Each has a small/default/large step: `smsize`/`size`/`xlsize` (icon and control sizing),
`smpadding`/`padding`/`xlpadding` (interior padding), `smspacing`/`spacing`/`xlspacing` (gaps
between sibling elements).

### Borders & shadow

`borderWidth` is the stroke width of the thick outline every bordered element draws.
`borderRadius` is the corner radius applied through ``SwiftUICore/View/nbBox(elevated:roundedCorners:)``.
`boxShadowX`/`boxShadowY` are the horizontal/vertical offset of the signature hard drop
shadow — set both to `0` for a fully flat, shadow-free look (as `.lavender` does).

### Typography

`fontDesign` is an optional `Font.Design` (`.rounded`, `.serif`, `.monospaced`…) applied to
the whole hierarchy by the root modifier. `nil` (the default) leaves the system font
untouched.

## Deriving a variant with `updateBy`

``NBTheme/updateBy(main:bw:overlay:background:blank:border:text:mainText:destructive:destructiveText:smsize:size:xlsize:smpadding:padding:xlpadding:smspacing:spacing:xlspacing:borderWidth:borderRadius:boxShadowX:boxShadowY:fontDesign:)``
returns a copy of a theme with only the tokens you name overridden — every unspecified
parameter carries over unchanged:

```swift
let danger = NBTheme.default.updateBy(main: .red, mainText: .white)
let dense = NBTheme.default.updateBy(padding: 8, spacing: 8, borderRadius: 0)
```

Every bundled preset is itself just `NBTheme.default.updateBy(...)` — read
[Theme+Presets.swift](https://github.com/rational-kunal/NeoBrutalism/blob/main/Sources/NeoBrutalism/Common/Theme%2BPresets.swift)
for the full recipe of each.

## Dark mode notes

- **`border` stays black in both light and dark mode, by design.** The thick black outline is
  the signature of the style — inverting it to white in dark mode would read as a completely
  different (and much softer) aesthetic. If you want a dark-mode-adapted border for a custom
  theme, override `border` explicitly with a `Color(light:dark:)` pair.
- **`blank` vs `bw`:** both default to white in light mode, but only `bw` inverts to near-black
  in dark mode. Use `bw` for a component's own bordered surface (so it inverts correctly), and
  `blank` for content that must stay white regardless of mode — e.g. the switch's thumb, which
  needs to stay visible against `main` in both light and dark.

## Preset themes

Five bundled looks besides `.default`, each a drop-in for the `theme:` argument of
``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` / ``SwiftUICore/View/nbTheme(_:)``. They vary
more than color — corner radius, border weight, shadow depth, padding/spacing density, and
font design each give the presets a distinct personality:

- ``NBTheme/sunnyPeach`` — warm yellow on peach (the classic neobrutalism look).
- ``NBTheme/bubblegum`` — pink on blush; pillowy capsule corners, airy padding, rounded font.
- ``NBTheme/seafoam`` — lime on sage; square corners, slab border, block shadow, monospaced font.
- ``NBTheme/tangerine`` — orange on cream; thick border and a huge poster-style shadow.
- ``NBTheme/lavender`` — purple on lilac; serif font, hairline border, completely flat (no shadow).

![Swatches for the default and five preset themes](preset-swatches)

```swift
ContentView().neoBrutalism(theme: .bubblegum, applyBackground: true)
```

![Live theme gallery from the Example app, light and dark mode](themes)
