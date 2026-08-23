# Badge

A small bordered pill for counts, statuses, and tags.

## Overview

``NBBadge`` wraps any content in the theme's border, radius, and fill:

```swift
NBBadge { Text("New") }
```

![A badge reading New in the accent fill](nb-badge-default)

## Types

`.default` uses the accent fill; `.neutral` uses the plain surface for a quieter tag.

```swift
NBBadge(type: .neutral) { Text("New") }
```

![A neutral badge reading New](nb-badge-neutral)

## Topics

### View

- ``NBBadge``
