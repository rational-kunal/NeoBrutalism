# Label

An icon and title pair, boxed to match the rest of the theme.

## Overview

`Label` needs nothing from you. With `.neoBrutalism()` at the root, this is already styled:

```swift
Label("Favorites", systemImage: "star.fill")
```

![A label pairing a star icon with the word Favorites](nb-label-default)

![A label pairing a gear icon with the word Settings](nb-label-icon)

## Inside a card

Labels stack cleanly inside a <doc:GroupBox>, which is the usual way to build a settings list
without reaching for `List`:

```swift
GroupBox {
    VStack(alignment: .leading, spacing: 12) {
        Label("Favorites", systemImage: "star.fill")
            .labelStyle(.neoBrutalism)
        Label("Settings", systemImage: "gear")
            .labelStyle(.neoBrutalism)
    }
}
.groupBoxStyle(.neoBrutalism())
```

## Styling it directly

You rarely need this. If a `Label` sits outside the root modifier's reach, apply
``NBLabelStyle`` yourself:

```swift
Label("Settings", systemImage: "gear")
    .labelStyle(.neoBrutalism)
```

## Topics

### Style

- ``NBLabelStyle``

## See Also

- <doc:LabeledContent>
