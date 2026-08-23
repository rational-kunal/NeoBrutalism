# Stepper

Increment and decrement a value with two bordered buttons.

## Overview

``NBStepper`` mirrors SwiftUI's `Stepper` initializer shape, so swapping it in is a rename:

```swift
@State private var quantity = 3

NBStepper("Quantity", value: $quantity, in: 0...10)
```

![A stepper labelled Quantity showing the value 3](nb-stepper-default)

## Bounds

The buttons disable themselves at the ends of the range, so the control communicates its own
limits without extra work:

```swift
NBStepper("Count", value: $count, in: 0...5)
```

![A stepper at its minimum, with the decrement button disabled](nb-stepper-min)

![A stepper at its maximum, with the increment button disabled](nb-stepper-max)

## Custom labels

The trailing-closure form takes any view, so a `Label` or a stack works in place of the string:

```swift
NBStepper(value: $items, in: 0...10) {
    Label("Items", systemImage: "cart")
}
```

![A stepper whose label pairs a cart icon with text](nb-stepper-custom-label)

## Disabled

```swift
NBStepper("Quantity", value: $quantity, in: 0...10)
    .disabled(true)
```

![A disabled stepper](nb-stepper-disabled)

## Topics

### View

- ``NBStepper``

## See Also

- <doc:Slider>
