# Slider

Drag a chunky thumb along a bordered track.

## Overview

SwiftUI's `Slider` has no style protocol, so NeoBrutalism ships ``NBSlider`` — a drop-in that
mirrors the native initializer, making adoption a rename:

```swift
@State private var volume = 0.5

NBSlider(value: $volume)
```

![A slider at roughly the halfway point](nb-slider-48)

The value is any `BinaryFloatingPoint`, and the default range is `0...1`.

![A slider at its minimum](nb-slider-0)

![A slider at its maximum](nb-slider-100)

## Range and step

Pass `in:` for a custom range and `step:` to snap:

```swift
NBSlider(value: $amount, in: 0...100, step: 5)
```

![A slider with a custom range and step snapping](nb-slider-step)

## Reacting to drags

`onEditingChanged` fires `true` when a drag begins and `false` when it ends — useful for
pausing live updates while the user is scrubbing:

```swift
NBSlider(value: $volume) { isEditing in
    isScrubbing = isEditing
}
```

## Disabled

```swift
NBSlider(value: $volume)
    .disabled(true)
```

![A disabled slider](nb-slider-disabled)

## Accessibility

The thumb keeps Apple's 44pt minimum touch target even though it's drawn smaller, and the
slider exposes standard adjustable-value semantics to VoiceOver.

## Topics

### View

- ``NBSlider``

## See Also

- <doc:Stepper>
