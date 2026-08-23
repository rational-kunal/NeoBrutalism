# LabeledContent

A caption on the left, its value on the right.

## Overview

`LabeledContent` is styled by the root modifier through ``NBLabeledContentStyle``:

```swift
LabeledContent("Username", value: "johndoe")
```

![A row reading Username on the left and johndoe on the right](nb-labeledcontent-basic)

Or explicitly:

```swift
LabeledContent("Username", value: "johndoe")
    .labeledContentStyle(.neoBrutalism)
```

## Building a detail card

Stacked inside a <doc:GroupBox>, `LabeledContent` rows make a tidy read-only detail panel:

```swift
GroupBox {
    VStack(spacing: 12) {
        LabeledContent("Username", value: "johndoe")
        LabeledContent("Email", value: "user@example.com")
        LabeledContent("Plan", value: "Pro")
    }
}
.groupBoxStyle(.neoBrutalism())
```

![A card containing three labelled value rows](nb-labeledcontent-groupbox)

The trailing-closure form takes any view, so the value side isn't limited to text — a
<doc:Badge> or a `Toggle` works just as well.

## Topics

### Style

- ``NBLabeledContentStyle``

## See Also

- <doc:Label>
- <doc:GroupBox>
