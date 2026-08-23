# Swipe actions

Reveal fully themed action tiles behind a row.

## Overview

SwiftUI's native `swipeActions` only exposes a tint — the tile chrome stays system-drawn. For a
reveal that matches the rest of the theme, use ``SwiftUICore/View/nbSwipeActions(edge:allowsFullSwipe:actions:initialOffset:)``:

```swift
Text("Delete Item")
    .padding(12)
    .nbListRow()
    .nbSwipeActions(actions: [
        NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
    ])
```

![A row at rest, with its action tile hidden](nb-swipe-closed)

![The same row swiped open, revealing a red delete tile](nb-swipe-single)

## Multiple actions

Actions reveal in order, outermost last. A `tint:` overrides the fill for non-destructive
actions:

```swift
.nbSwipeActions(actions: [
    NBSwipeAction("Pin", systemImage: "pin.fill", tint: .blue) {},
    NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
])
```

![A row swiped open, revealing a blue pin tile and a red delete tile](nb-swipe-two)

## Options

| Parameter | Effect |
|---|---|
| `edge` | Which side the actions reveal from. Defaults to `.trailing`. |
| `allowsFullSwipe` | Whether a long swipe triggers the last action outright. Defaults to `true`. |
| `initialOffset` | Starting offset, mainly useful for previews and snapshots. |

`role: .destructive` picks up the theme's `destructive` token, so delete tiles stay consistent
across the app without hardcoding red.

## Topics

### Modifier

- ``SwiftUICore/View/nbSwipeActions(edge:allowsFullSwipe:actions:initialOffset:)``

### Type

- ``NBSwipeAction``

## See Also

- <doc:ListsAndForms>
