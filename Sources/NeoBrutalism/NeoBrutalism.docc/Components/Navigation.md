# Navigation

Theme the navigation bar to match the screen beneath it.

## Overview

Navigation chrome isn't reachable through the SwiftUI environment, so it gets an opt-in helper:
``SwiftUICore/View/nbNavigationBar()``, applied to the screen's content.

```swift
NavigationStack {
    Text("Content")
        .navigationTitle("Navigation Title")
        .nbNavigationBar()
}
```

![A navigation bar themed to match the neobrutalism style](nb-navigation-bar)

Apply it inside the `NavigationStack`, on the content view that declares the title — not to the
stack itself.

## With a list

The usual full-screen shape combines it with the <doc:ListsAndForms> helpers:

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

## Topics

### Modifier

- ``SwiftUICore/View/nbNavigationBar()``

## See Also

- <doc:ListsAndForms>
