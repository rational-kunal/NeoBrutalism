# Lists and forms

Turn `List` and `Form` rows into bordered cards.

## Overview

SwiftUI gives `List` and `Form` no style protocol, so the root modifier honestly cannot reach
them. Two opt-in helpers do the job instead:

- ``SwiftUICore/View/nbList()`` on the `List`/`Form` itself hides the system background and
  tightens row spacing.
- ``SwiftUICore/View/nbListRow(elevated:)`` on each row's content draws it as a card.

```swift
List {
    ForEach(items) { item in
        Text(item.title)
            .nbListRow()
    }
}
.nbList()
```

![A list of three bordered row cards](nb-list-basic)

> Important: Both are required. `nbList()` alone leaves the system row chrome in place;
> `nbListRow()` alone leaves the list's own background showing through.

## Forms

`Form` is a `List` underneath, so the same pair applies — and the controls inside each row are
still styled by the root modifier:

```swift
Form {
    Section("Settings") {
        Toggle("Enable Notifications", isOn: $notify)
            .nbListRow()

        TextField("Enter text", text: $text)
            .nbListRow()

        LabeledContent("House") {
            Text("Gryffindor")
        }
        .nbListRow()
    }
}
.nbList()
.neoBrutalism()
```

![A form section containing a toggle, a text field, and a labelled value, each as a card](nb-form-basic)

## Flat rows

Pass `elevated: false` to drop the shadow when rows sit close together and stacked shadows read
as clutter:

```swift
Text(item.title)
    .nbListRow(elevated: false)
```

## Topics

### Modifiers

- ``SwiftUICore/View/nbList()``
- ``SwiftUICore/View/nbListRow(elevated:)``

## See Also

- <doc:SwipeActions>
- <doc:Navigation>
