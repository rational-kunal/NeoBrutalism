# GroupBox

The bordered card that most neobrutalism layouts are built from.

## Overview

`GroupBox` needs nothing from you. With `.neoBrutalism()` at the root, this is already a card:

```swift
GroupBox("Hogwarts Letter") {
    Text("You have been accepted!")
}
```

![A card with a title and body text](nb-groupbox-default)

Reach for ``NBGroupBoxStyle`` only when you want a **variant** — a quieter fill, or a card with
no shadow. Both are below.

## Types

`.default` fills with the theme's surface; `.neutral` is the quieter variant.

```swift
GroupBox("Quidditch Gear") {
    Text("Broomstick, robes, and a golden snitch.")
}
.groupBoxStyle(.neoBrutalism(type: .neutral))
```

![A neutral card](nb-groupbox-neutral)

## Elevation

`elevated: false` drops the shadow, leaving the border. Use it for cards nested inside another
bordered surface, where stacked shadows get noisy:

```swift
GroupBox {
    Text("Flat card with no label")
}
.groupBoxStyle(.neoBrutalism(elevated: false))
```

![A flat card with no shadow](nb-groupbox-flat)

## Labels

The label is optional, and it takes any view — not just a string:

```swift
GroupBox {
    Text("Card with only main content")
}
.groupBoxStyle(.neoBrutalism())
```

![A card with body content and no title](nb-groupbox-nolabel)

```swift
GroupBox {
    Text("You have 3 new messages.")
} label: {
    HStack {
        Image(systemName: "bell.fill")
        Text("Notifications")
    }
}
.groupBoxStyle(.neoBrutalism())
```

![A card whose title pairs a bell icon with text](nb-groupbox-icon)

## Topics

### Style

- ``NBGroupBoxStyle``

## See Also

- <doc:Collapsable>
- <doc:LabeledContent>
