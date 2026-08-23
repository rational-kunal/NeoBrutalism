# Segmented picker

A row of bordered segments where one is always selected.

## Overview

``NBSegmentedPicker`` replaces `Picker` with `.segmented` style. Each child tags itself with the
value it selects via ``SwiftUICore/View/nbSegment(_:)``:

```swift
@State private var size = "One"

NBSegmentedPicker(selection: $size) {
    Text("One").nbSegment("One")
    Text("Two").nbSegment("Two")
    Text("Three").nbSegment("Three")
}
```

![A segmented picker with the first of three segments selected](nb-segmented-first)

![A segmented picker with the middle segment selected](nb-segmented-middle)

## Any Hashable value

Segments can carry any `Hashable` value, not just strings:

```swift
NBSegmentedPicker(selection: $size) {
    Text("S").nbSegment(0)
    Text("M").nbSegment(1)
    Text("L").nbSegment(2)
}
```

![A segmented picker using integer values for S, M, and L](nb-segmented-int)

## Disabled

```swift
NBSegmentedPicker(selection: $size) {
    Text("One").nbSegment("One")
    Text("Two").nbSegment("Two")
}
.disabled(true)
```

![A disabled segmented picker](nb-segmented-disabled)

## Topics

### Views

- ``NBSegmentedPicker``
- ``NBSegmentItem``
- ``SwiftUICore/View/nbSegment(_:)``
- ``NBSegmentBuilder``

## See Also

- <doc:Radio>
- <doc:Tabs>
