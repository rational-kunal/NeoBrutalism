# Progress

A bordered bar that fills as work completes.

## Overview

`ProgressView` needs nothing from you. With `.neoBrutalism()` at the root, this is already styled:

```swift
ProgressView(value: 0.52)
```

![A progress bar filled to just over half](nb-progress-52)

![An empty progress bar](nb-progress-0)

![A full progress bar](nb-progress-100)

## Indeterminate progress

A `ProgressView` with no value renders as a label with an animated indeterminate bar — use it
when you can't estimate completion:

```swift
ProgressView { Text("Loading...") }
    .progressViewStyle(.neoBrutalism)
```

![An indeterminate progress view labelled Loading](nb-progress-indeterminate)

The animation respects Reduce Motion.

## Styling it directly

You rarely need this. If a `ProgressView` sits outside the root modifier's reach, apply
``NBProgressViewStyle`` yourself:

```swift
ProgressView(value: progress)
    .progressViewStyle(.neoBrutalism)
```

## Topics

### Style

- ``NBProgressViewStyle``

## See Also

- <doc:Gauge>
- <doc:Skeleton>
