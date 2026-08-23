# Menu

A tappable trigger that reveals a list of actions.

## Overview

A native `Menu` is styled by the root modifier — its **trigger** picks up ``NBMenuStyle``:

```swift
Menu("Options") {
    Button("Edit") {}
    Button("Delete") {}
}
```

![A neobrutalism-styled menu trigger labelled Options](nb-menu-default)

```swift
Menu {
    Button("Cut") {}
    Button("Copy") {}
} label: {
    Label("Actions", systemImage: "ellipsis.circle")
}
.menuStyle(.neoBrutalism)
```

![A menu trigger with an icon and text](nb-menu-icon)

> Important: The dropdown a native `Menu` presents is owned by UIKit and cannot be restyled from
> SwiftUI. Only the trigger is themed. If the popup itself needs to match, use ``NBMenu``.

## A fully themed menu

``NBMenu`` draws both the trigger and the popup, so the whole interaction stays on-brand. It
takes ``NBMenuItem`` values instead of arbitrary buttons:

```swift
NBMenu {
    NBMenuItem("Edit", systemImage: "pencil") {}
    NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
} label: {
    Text("Options")
}
```

![The NBMenu trigger](nb-menu-nbmenu)

Items accept a `role` — `.destructive` picks up the theme's `destructive` token — and
``NBMenuItem/divider`` inserts a separator:

```swift
NBMenu {
    NBMenuItem("Rename", systemImage: "pencil") {}
    NBMenuItem.divider
    NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
} label: {
    Label("More", systemImage: "ellipsis")
}
```

## Choosing between them

| Use | When |
|---|---|
| `Menu` + ``NBMenuStyle`` | You want native menu behavior and only care that the trigger matches. |
| ``NBMenu`` | The dropdown has to look neobrutalist too. |

## Topics

### Style

- ``NBMenuStyle``

### Views

- ``NBMenu``
- ``NBMenuItem``
- ``NBMenuBuilder``
