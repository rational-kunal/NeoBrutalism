# Radio

Pick exactly one option from a short, visible list.

## Overview

``NBRadioGroup`` owns the selection; each ``NBRadioItem`` declares the value it stands for. The
group publishes the current selection through the environment, so items don't need a binding of
their own.

```swift
@State private var choice = 0

NBRadioGroup(value: $choice) {
    NBRadioItem(value: 0) { Text("First") }
    NBRadioItem(value: 1) { Text("Second") }
}
```

![A radio group with the first of two options selected](nb-radio-group)

The value type only has to be `Equatable`, so enums, strings, and identifiers all work.

## Mixing in other content

Anything that isn't an `NBRadioItem` renders as-is, which is how you give a group a heading
without a separate container:

```swift
NBRadioGroup(value: $choice) {
    Text("Choose an option")
        .font(.title2)

    NBRadioItem(value: 0) { Text("Option A") }
    NBRadioItem(value: 1) { Text("Option B") }
    NBRadioItem(value: 2) { Text("Option C") }
}
```

![A radio group with a title above three options, the third selected](nb-radio-label)

## Standalone items

An ``NBRadioItem`` can live outside a group when you want to drive selection yourself — set
`nbSelectedRadioItemValue` in the environment and the item matches its own `value` against it.

![A selected standalone radio item](nb-radio-item-selected)

![An unselected standalone radio item](nb-radio-item-unselected)

## Radio-styled toggles

For a single on/off control that should read as a radio dot rather than a box, apply
``NBRadioStyle`` to a plain `Toggle`:

```swift
Toggle("Only this one", isOn: $isOn)
    .toggleStyle(.neoBrutalismRadio)
```

## Topics

### Views

- ``NBRadioGroup``
- ``NBRadioItem``
- ``NBRadioIndicator``

### Style

- ``NBRadioStyle``

## See Also

- <doc:SegmentedPicker>
- <doc:Checkbox>
