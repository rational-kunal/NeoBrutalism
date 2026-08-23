# Getting Started

Install NeoBrutalism and restyle a plain SwiftUI screen with one modifier.

## Install

Add NeoBrutalism with Swift Package Manager:

1. In Xcode, go to **File → Add Package Dependencies**.
2. Enter the repository URL: `https://github.com/rational-kunal/NeoBrutalism.git`
3. Choose the version or branch you want to use.

**Requirements:** iOS 17+ · Swift 6 · Xcode 16. Zero runtime dependencies.

## Apply the root modifier

``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` is the whole pitch: apply it once at the
root of a view hierarchy and every supported native control underneath picks up the
neobrutalism look through its normal SwiftUI style protocol.

```swift
import NeoBrutalism
import SwiftUI

ContentView()
    .neoBrutalism(applyBackground: true)
```

![A screen of native SwiftUI controls, all restyled by the root modifier](nb-kitchen-sink)

Every control above is plain SwiftUI — no per-view modifiers. `applyBackground: true` also fills
the safe-area-ignoring background with the theme's `background` color, so a two-line app is fully
styled with no `ZStack` or manual background fill.

> Important: Apply `.neoBrutalism()` as the **outermost** modifier. It installs the theme's
> defaults, so anything it wraps can be overridden per-view — but a per-view override placed
> *after* it will be overwritten by the defaults instead.

Want a different look? Swap the theme, same call:

```swift
ContentView().neoBrutalism(theme: .bubblegum, applyBackground: true)
```

See <doc:Theming> for the five bundled presets and how to build your own.

## What the root modifier covers

`.neoBrutalism()` styles every one of these through their standard SwiftUI style protocol —
zero per-view modifiers required:

<doc:Button> · <doc:Switch> · <doc:TextInput> · <doc:Progress> · <doc:Gauge> · <doc:Label> ·
<doc:LabeledContent> · <doc:Menu> (trigger only) · <doc:Accordion> · <doc:ControlGroup> ·
<doc:GroupBox>

Two deliberate omissions from that automatic coverage:

- The default `Toggle` style is the **switch**. Opt a specific `Toggle` into the
  <doc:Checkbox> look with `.toggleStyle(.neoBrutalismCheckbox)`, or the <doc:Radio> dot with
  `.toggleStyle(.neoBrutalismRadio)`.
- SwiftUI gives `List`/`Form` and navigation chrome no style protocol to hook into, so the
  root modifier can't reach them — see the next section.

## Styling List, Form, and navigation

`List`/`Form` and the navigation bar aren't reachable through the environment, so they get
dedicated helper modifiers instead of a style protocol:

```swift
NavigationStack {
    List {
        ForEach(items) { item in
            Text(item.title)
                .nbListRow()
        }
    }
    .nbList()
    .navigationTitle("Spells")
    .nbNavigationBar()
}
.neoBrutalism()
```

- ``SwiftUICore/View/nbList()`` on the `List`/`Form` itself hides the system background and
  tightens row spacing.
- ``SwiftUICore/View/nbListRow(elevated:)`` on each row's content renders it as a bordered
  neobrutalism card.
- ``SwiftUICore/View/nbNavigationBar()`` on the screen content themes the navigation bar to match.

`TextEditor` (no style protocol either) gets the same treatment via
``SwiftUICore/View/nbTextEditor()``, and controls with no native counterpart at all — sliders,
steppers, radio groups — ship as drop-in `NB*` views (``NBSlider``, ``NBStepper``,
``NBRadioGroup``) that mirror the native initializer shape, so adopting them is a rename, not
a rewrite.

Full details in <doc:ListsAndForms> and <doc:Navigation>.

## Find the component you need

<doc:Components> has a page per component: what it looks like in light and dark, the code to
paste, and its variants, states, and disabled appearance.

## See it in a real app

The bundled Example app opens on a small todo list where the text field, add button, progress
bar, checkboxes, list rows, sort menu, and delete-confirmation dialog are all styled by a
single `.neoBrutalism()` call at the screen's root. Open `Example/` in Xcode and run it, or
read [TodoView.swift](https://github.com/rational-kunal/NeoBrutalism/blob/main/Example/Sources/TodoView.swift)
directly — about 200 lines, only two of which are deliberate per-view style overrides.

![The Todo screen of the Example app, light and dark mode](todo)

Every component also has a live entry in the Example app's Gallery tab, grouped the same way
components are grouped in this documentation.

![The component gallery tab of the Example app, light and dark mode](gallery)
