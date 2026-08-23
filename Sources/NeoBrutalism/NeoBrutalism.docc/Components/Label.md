# Label

An icon and title pair, boxed to match the rest of the theme.

## Overview

`Label` is styled by the root modifier through ``NBLabelStyle``:

```swift
Label("Favorites", systemImage: "star.fill")
```

![A label pairing a star icon with the word Favorites](nb-label-default)

Or explicitly:

```swift
Label("Settings", systemImage: "gear")
    .labelStyle(.neoBrutalism)
```

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

## Topics

### Style

- ``NBLabelStyle``

## See Also

- <doc:LabeledContent>
