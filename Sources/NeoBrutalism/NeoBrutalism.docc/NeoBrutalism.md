# ``NeoBrutalism``

Neobrutalism design for native SwiftUI — one modifier restyles your app.

## Overview

Write plain SwiftUI. Add `.neoBrutalism()` at the root. Every control underneath keeps its own
code, accessibility, and behavior, and picks up thick borders, hard shadows, and the theme's
colors through its standard SwiftUI style protocol.

```swift
struct ContentView: View {
    @State private var shieldOn = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Shield Charm", isOn: $shieldOn)
            Button("Cast Spell") {}
        }
        .padding()
        .neoBrutalism()
    }
}
```

![The Example app cycling through its Todo, Gallery, and Themes tabs in light and dark mode](demo)

Where SwiftUI has no style protocol to hook into — `List`, navigation chrome, sliders, radio
groups — NeoBrutalism ships helper modifiers or drop-in `NB*` views that mirror the native
initializer shape.

### Where to go next

| If you want to… | Read |
|---|---|
| Install it and style your first screen | <doc:GettingStarted> |
| See a component and copy its code | <doc:Components> |
| Change colors, spacing, or borders | <doc:Theming> |

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:Components>
- <doc:Theming>

### Root modifier

- ``SwiftUICore/View/neoBrutalism(theme:applyBackground:)``

### Theme

- ``NBTheme``
- ``SwiftUICore/View/nbTheme(_:)``

### Building your own components

Every bordered surface in the library funnels through these, so a custom view can match the
built-ins exactly rather than approximating them.

- ``SwiftUICore/View/nbBox(elevated:roundedCorners:)``
- ``SwiftUICore/View/nbPressEffect(isPressed:roundedCorners:)``
- ``SwiftUICore/View/nbPressEffect(elevated:isPressed:roundedCorners:)``
- ``NBCornerSet``

### Supporting types

- ``AnyEquatable``
