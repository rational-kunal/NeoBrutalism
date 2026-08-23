# ControlGroup

A joined row of related buttons.

## Overview

`ControlGroup` needs nothing from you — the root modifier styles it, and it welds its
children into one bordered strip:

```swift
ControlGroup {
    Button("Bold") {}
    Button("Italic") {}
    Button("Underline") {}
}
```

![Three text buttons joined into one bordered strip](nb-controlgroup-default)

## Icon buttons

`Label` children collapse to their icons, which is the usual shape for a toolbar:

```swift
ControlGroup {
    Button {} label: { Label("Cut", systemImage: "scissors") }
    Button {} label: { Label("Copy", systemImage: "doc.on.doc") }
    Button {} label: { Label("Paste", systemImage: "doc.on.clipboard") }
}
.controlGroupStyle(.neoBrutalism)
```

![A control group of three icon buttons](nb-controlgroup-icons)

## Styling it directly

You rarely need this. If a `ControlGroup` sits outside the root modifier's reach, apply
``NBControlGroupStyle`` yourself:

```swift
ControlGroup {
    Button("Bold") {}
    Button("Italic") {}
}
.controlGroupStyle(.neoBrutalism)
```

## Topics

### Style

- ``NBControlGroupStyle``

## See Also

- <doc:SegmentedPicker>
- <doc:Button>
