# Progress

A bordered bar that fills as work completes.

## Overview

`ProgressView` is styled by the root modifier through ``NBProgressViewStyle``:

```swift
ProgressView(value: 0.52)
```

![A progress bar filled to just over half](nb-progress-52)

Or apply it to a single view:

```swift
ProgressView(value: progress)
    .progressViewStyle(.neoBrutalism)
```

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

## Topics

### Style

- ``NBProgressViewStyle``

## See Also

- <doc:Gauge>
- <doc:Skeleton>
