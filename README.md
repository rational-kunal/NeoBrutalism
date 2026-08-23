<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/media/logo-dark.svg">
  <img src="docs/media/logo-light.svg" width="360" alt="NeoBrutalism">
</picture>

[![CI](https://img.shields.io/github/actions/workflow/status/rational-kunal/NeoBrutalism/ci.yml?style=flat-square&label=CI)](https://github.com/rational-kunal/NeoBrutalism/actions/workflows/ci.yml) [![Documentation](https://img.shields.io/badge/docs-DocC-blue?style=flat-square)](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism) ![GitHub Tag](https://img.shields.io/github/v/tag/rational-kunal/NeoBrutalism?sort=semver&style=flat-square&label=version) ![Platform](https://img.shields.io/badge/platform-iOS%2017%2B-lightgrey?style=flat-square) ![Swift](https://img.shields.io/badge/swift-6.0-orange?style=flat-square) ![License](https://img.shields.io/github/license/rational-kunal/NeoBrutalism?style=flat-square)

# NeoBrutalism

**Bold neobrutalism styling for native SwiftUI — one modifier, no reimplementation.** Write plain
SwiftUI, add `.neoBrutalism()` at the root, and every control keeps its own code, accessibility,
and behavior.

```swift
struct ContentView: View {
    @State private var shieldOn = false

    // Plain SwiftUI…
    var body: some View {
        VStack(spacing: 16) {
            Toggle("Shield Charm", isOn: $shieldOn)
            Button("Cast Spell") {}
        }
        .padding()
        // …one modifier later:
        .neoBrutalism()
    }
}
```

<p align="center">
  <img src="docs/media/demo.gif" width="300" alt="The Example app cycling through its Todo, Gallery, and Themes tabs in light and dark mode" />
</p>

### 📖 [Read the documentation →](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism)

| | |
|---|---|
| [**Getting Started**](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism/gettingstarted) | Install it and style your first screen. |
| [**Components**](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism/components) | A page per component — what it looks like in light and dark, the code to paste, every variant and state. |
| [**Theming**](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism/theming) | Tokens, presets, and building a theme from scratch. |

This README is the tour; the docs are the manual.

## Quick start

**Requirements:** iOS 17+ · Swift 6 · Xcode 16. Zero runtime dependencies.

Add NeoBrutalism with Swift Package Manager — in Xcode, **File → Add Package Dependencies**, then
enter `https://github.com/rational-kunal/NeoBrutalism.git`.

Two lines to a fully styled app:

```swift
import NeoBrutalism
import SwiftUI

ContentView()
    .neoBrutalism(applyBackground: true)
```

Want a different look? Swap the theme, same call:

```swift
ContentView().neoBrutalism(theme: .bubblegum, applyBackground: true)
```

<p align="center">
  <img src="docs/media/preset-swatches.png" width="500" alt="Swatches for the .default, .sunnyPeach, .bubblegum, .seafoam, .tangerine, and .lavender preset themes" />
</p>

## What gets styled

| Layer | Covers | How |
|---|---|---|
| **Root modifier** | Button · Toggle · TextField/SecureField · ProgressView · Gauge · Label · LabeledContent · Menu trigger · DisclosureGroup · ControlGroup · GroupBox | one `.neoBrutalism()` call, zero per-view modifiers |
| **Helpers** | List & Form · navigation bars · TextEditor · sheets · alerts · swipe actions · skeleton loading | `nbList()` · `nbListRow()` · `nbNavigationBar()` · `nbTextEditor()` · `nbDrawer()` · `nbDialog()` · `nbSwipeActions()` · `nbSkeleton()` |
| **Drop-in views** | Slider · Stepper · segmented Picker · Radio · Tabs · Alert · Badge · Collapsable · Skeletons | `NBSlider` · `NBStepper` · `NBSegmentedPicker` · `NBRadioGroup` · `NBTabView` · `NBAlert` · `NBBadge` · `NBCollapsable` · `NBRoundSkeleton`/`NBTextSkeleton` |

Every component has a live entry in the Example app's Gallery tab, and its own page in
[the component catalog](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism/components) —
with the code to paste and every variant, state, and disabled appearance shown in light and dark.

<p align="center">
  <img src="docs/media/gallery-light.png" width="280" alt="The component gallery tab of the Example app in light mode" />
  <img src="docs/media/gallery-dark.png" width="280" alt="The component gallery tab of the Example app in dark mode" />
</p>

## A real screen, one modifier

The Example app opens on a small todo app. The text field, add button, progress bar, checkboxes,
list rows, sort menu, and the "delete all" dialog are all styled by a single `.neoBrutalism()` call
at the root of the screen.

<p align="center">
  <img src="docs/media/todo-light.png" width="280" alt="The Todo screen of the Example app in light mode" />
  <img src="docs/media/todo-dark.png" width="280" alt="The Todo screen of the Example app in dark mode" />
</p>

The shape of it:

```swift
var body: some View {
    VStack {
        TextField("Add a task…", text: $newTodoText)  // nothing on this…
        Button(action: addTodo) { Image(systemName: "plus") }  // …or this…
        ProgressView(value: progress)                 // …or this…
        List { /* rows via nbListRow() */ }
    }
    .neoBrutalism()                                   // …one call styles it all
}
```

The full source is [TodoView.swift](Example/Sources/TodoView.swift) — 204 lines, of which exactly
two are per-view style modifiers, and both are deliberate design choices rather than workarounds:
one checkbox opt-in (the root default for `Toggle` is the switch, matching native semantics) and
one neutral button variant for the secondary "delete all" action.

Open [Example](Example/) in Xcode to poke around; the screenshots and demo GIF in this README are
generated by [capture.sh](Example/capture.sh) in that folder.

## Theming

Every component reads its colors and metrics from one `NBTheme` value, injected through the
SwiftUI environment. Components never hardcode a color, a radius, or a shadow offset — override the
theme for a whole app or any subtree, or derive a variant with `updateBy(...)`:

```swift
let theme = NBTheme.default.updateBy(background: .black, mainText: .white)

ContentView().nbTheme(theme)
```

Five presets ship besides `.default`, and they vary more than color — corner radius, border weight,
shadow depth, padding density, and font design each give them a distinct personality:

| Preset | Personality |
|---|---|
| `.sunnyPeach` | Warm yellow on peach — the classic look |
| `.bubblegum` | Pink on blush; pillowy capsule corners, airy padding, rounded font |
| `.seafoam` | Lime on sage; square corners, slab border, block shadow, monospaced font |
| `.tangerine` | Orange on cream; thick border and a huge poster-style shadow |
| `.lavender` | Purple on lilac; serif font, hairline border, completely flat (no shadow) |

<p align="center">
  <img src="docs/media/themes-light.png" width="220" alt="Live theme gallery, light mode" />
  <img src="docs/media/themes-dark.png" width="220" alt="Live theme gallery, dark mode" />
</p>

The full token reference — colors, spacing, borders, shadow, typography — and a walkthrough for
building a theme from scratch are in the
[Theming guide](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism/theming).

## Design notes

**Native controls are restyled, never reimplemented.** SwiftUI's style protocols — `ButtonStyle`,
`ToggleStyle`, `TextFieldStyle`, and eight more — propagate down the environment, so a single call
at the root reaches every control beneath it. The payoff is that VoiceOver, Dynamic Type, focus
handling, keyboard behavior, and every future SwiftUI fix keep working, because the control is
still Apple's. Adopting the library is adding one line, not migrating a screen.

**Where SwiftUI offers no hook, the gap is filled deliberately — and the ceiling is documented.**
Three cases, in descending order of preference:

1. *A style protocol exists* → implement it. Eleven of them are covered.
2. *No protocol, but the view is reachable* → an opt-in helper modifier (`nbList()`,
   `nbNavigationBar()`, `nbTextEditor()`). `List`/`Form` and navigation chrome live here: they
   aren't stylable through the environment, so the root modifier honestly cannot reach them.
3. *No native counterpart at all* → a drop-in `NB*` view that mirrors the native initializer shape,
   so migration is a rename. `NBSlider`, `NBStepper`, `NBSegmentedPicker`, `NBRadioGroup`.

Some ceilings are the system's, not ours, and the docs say so rather than shipping an off-brand
compromise: `Menu`'s dropdown is UIKit-owned (use `NBMenu` if you need the popup themed too), and
native swipe-action chrome only exposes a tint (use `nbSwipeActions()` for a fully themed reveal).

**One theme value, one box modifier.** `NBTheme` is a single environment value; every bordered
surface funnels through one shared `nbBox()` modifier and one shared press effect, so "pressed"
means the same thing on a button, a checkbox, and a stepper. Reduce Motion is respected throughout.

**Testing.** 119 snapshot tests render every component in light and dark against 238 stored
reference images, on a pinned simulator (iPhone 16 · iOS 26.2) so text metrics can't drift between
machines. 22 unit tests cover API shape and the pure helpers. Reference images are recorded by CI
rather than locally — a dedicated workflow is the single source of truth, which keeps "works on my
Mac" out of the diff. Every PR runs the suite plus a DocC build check.

Those same reference images are what illustrate the component catalog: the docs build derives its
imagery from `__Snapshots__` rather than from a second, hand-captured set, so the documentation
cannot drift from what the components actually render.

## Built with NeoBrutalism

- [Mismatch](https://github.com/rational-kunal/mismatch)
- _Building something with NeoBrutalism? [Open a PR](https://github.com/rational-kunal/NeoBrutalism/pulls) adding it here._

## Contributing

Found a bug, or missing a component you need? Open an issue or send a PR — both are welcome.
[CONTRIBUTING.md](CONTRIBUTING.md) covers dev setup, how to build a new component, and the PR
checklist; [ROADMAP.md](ROADMAP.md) shows what's planned and what's already shipped.

---

<small>The credit for the design belongs to <a href="https://www.neobrutalism.dev">neobrutalism.dev</a>.</small>
