# Gauge

A compact readout for a value inside a known range.

## Overview

`Gauge` is styled by the root modifier through ``NBGaugeStyle``:

```swift
Gauge(value: 0.52) { Text("Half") }
```

![A gauge showing a value near the middle of its range](nb-gauge-52)

Or explicitly:

```swift
Gauge(value: level) { Text("Charge") }
    .gaugeStyle(.neoBrutalism)
```

![A gauge at zero](nb-gauge-0)

![A gauge at full](nb-gauge-100)

## Progress or gauge?

Both show a fraction, but they answer different questions. Reach for <doc:Progress> when
something is *happening* and will finish; reach for `Gauge` when you're reporting a *level* that
simply is what it is — battery, capacity, score.

## Topics

### Style

- ``NBGaugeStyle``

## See Also

- <doc:Progress>
