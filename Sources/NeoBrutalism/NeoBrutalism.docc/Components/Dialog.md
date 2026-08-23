# Dialogs and drawers

Modal surfaces that match the theme.

## Overview

Native `alert` and `sheet` presentations are system-drawn and can't be themed from SwiftUI. Two
modifiers provide themed replacements.

## Dialog

``SwiftUICore/View/nbDialog(_:isPresented:actions:message:)`` presents a centered confirmation
card over a scrim, mirroring the shape of SwiftUI's own `alert(_:isPresented:actions:message:)`:

```swift
ContentView()
    .nbDialog("Delete spell?", isPresented: $showConfirm) {
        Button("Delete", role: .destructive) { delete() }
        Button("Keep") {}
    } message: {
        Text("This cannot be undone.")
    }
```

![A confirmation dialog card asking Delete spell?, with Delete and Keep buttons](nb-dialog-card)

Buttons in `actions` are ordinary SwiftUI buttons, so `role: .destructive` picks up the theme's
`destructive` token.

## Drawer

``SwiftUICore/View/nbDrawer(isPresented:onDismiss:content:)`` slides a themed panel up from the
bottom — the themed counterpart to `sheet`:

```swift
ContentView()
    .nbDrawer(isPresented: $showDrawer) {
        VStack(spacing: 16) {
            Text("Sort by")
            Button("Newest") {}
            Button("Oldest") {}
        }
        .padding()
    }
```

`onDismiss` fires after the drawer closes, whether it was dismissed by a button or by the user
swiping it away.

## Topics

### Modifiers

- ``SwiftUICore/View/nbDialog(_:isPresented:actions:message:)``
- ``SwiftUICore/View/nbDrawer(isPresented:onDismiss:content:)``

## See Also

- <doc:Alert>
