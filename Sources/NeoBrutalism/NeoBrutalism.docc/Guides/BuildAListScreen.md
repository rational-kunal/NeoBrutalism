# Build a list screen

A navigation bar, a list of cards, and swipe-to-delete.

## Overview

This is the shape most apps start with, and the one place NeoBrutalism asks for the most from
you — `List` and navigation bars can't be reached by the root modifier, so they take their own
modifiers.

## The whole thing

```swift
struct SpellsView: View {
    @State private var spells = ["Lumos", "Nox", "Accio"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(spells, id: \.self) { spell in
                    Text(spell)
                        .nbListRow()
                        .nbSwipeActions(actions: [
                            NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {
                                spells.removeAll { $0 == spell }
                            }
                        ])
                }
            }
            .nbList()
            .navigationTitle("Spells")
            .nbNavigationBar()
        }
        .neoBrutalism(applyBackground: true)
    }
}
```

![A list of three bordered row cards](nb-list-basic)

## What each line is doing

| Line | Why it's there |
|---|---|
| `.nbListRow()` | Draws each row as a bordered card. Goes on the row's **content**. |
| `.nbList()` | Hides the system list background and tightens spacing. Goes on the **`List`**. |
| `.nbNavigationBar()` | Themes the navigation bar. Goes on the **content**, inside the stack. |
| `.neoBrutalism()` | Styles everything else, and must be **outermost**. |

The one that trips people up is needing both `nbList()` and `nbListRow()`. With only the first,
rows keep their system chrome; with only the second, the list background shows through.

## Swipe actions

Native `swipeActions` only lets you tint the system tile, so a themed reveal uses
``SwiftUICore/View/nbSwipeActions(edge:allowsFullSwipe:actions:initialOffset:)`` instead:

![A row swiped open, revealing a red delete tile](nb-swipe-single)

`role: .destructive` picks up the theme's `destructive` color, so you never hardcode red.

## Forms work the same way

`Form` is a `List` underneath, so the same two modifiers apply — and the controls inside each
row are styled for free:

```swift
Form {
    Section("Settings") {
        Toggle("Enable Notifications", isOn: $notify).nbListRow()
        TextField("Enter text", text: $text).nbListRow()
    }
}
.nbList()
```

![A form section containing a toggle and a text field, each as a card](nb-form-basic)

## See Also

- <doc:ListsAndForms>
- <doc:Navigation>
- <doc:SwipeActions>
