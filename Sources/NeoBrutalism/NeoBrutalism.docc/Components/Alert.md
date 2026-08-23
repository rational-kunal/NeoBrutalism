# Alert

An inline banner that draws attention without interrupting.

## Overview

``NBAlert`` is a bordered banner you place in the layout — not a modal. For a modal
confirmation, see <doc:Dialog>.

The shorthand initializer covers the common case:

```swift
NBAlert(
    "Heads up",
    message: "Something happened that you should know about.",
    systemImage: "exclamationmark.triangle.fill"
)
```

![An alert banner with a warning icon, heading, and message](nb-alert-default)

## Custom content

The full form takes builders for the message, icon, and heading, so any view works in each slot:

```swift
NBAlert {
    Text("Something happened that you should know about.")
} icon: {
    Image(systemName: "exclamationmark.triangle.fill")
} head: {
    Text("Heads up")
}
```

## Types

`.neutral` tones the banner down to the plain surface — and the icon is optional, so omitting it
gives a quieter, text-only notice:

```swift
NBAlert(type: .neutral) {
    Text("Something happened that you should know about.")
} head: {
    Text("Heads up")
}
```

![A neutral alert banner with no icon](nb-alert-neutral)

## Topics

### View

- ``NBAlert``

## See Also

- <doc:Dialog>
- <doc:Badge>
