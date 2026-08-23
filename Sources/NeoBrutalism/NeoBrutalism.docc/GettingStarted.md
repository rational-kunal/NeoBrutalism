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

Two things it deliberately leaves to you:

- A `Toggle` is a **switch**. Ask for the <doc:Checkbox> with
  `.toggleStyle(.neoBrutalismCheckbox)`, or the <doc:Radio> dot with
  `.toggleStyle(.neoBrutalismRadio)`.
- `List`, `Form`, and navigation bars need their own modifiers — see the next section.

## Lists, forms, and navigation

These three need modifiers from you — the root modifier can't reach them:

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

`TextEditor` needs ``SwiftUICore/View/nbTextEditor()`` the same way. And a few controls have no
native equivalent at all, so they ship as `NB…` views — ``NBSlider``, ``NBStepper``,
``NBRadioGroup`` — copying the native initializer shape, so switching is a rename.

<doc:WhatDoIType> lists every component and its one line.

## Find the component you need

<doc:WhatDoIType> is the fast path: every component and its one line, in one table.

<doc:Components> is the long form — a page per component with what it looks like in light and
dark, the code to paste, and its variants, states, and disabled appearance.

Or start from a goal: <doc:BuildAForm> and <doc:BuildAListScreen> walk through a whole screen
and point out which lines needed anything at all.

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
