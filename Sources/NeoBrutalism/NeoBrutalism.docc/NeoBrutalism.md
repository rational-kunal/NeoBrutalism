# ``NeoBrutalism``

Neobrutalism design for native SwiftUI — one modifier restyles your app.

## Overview

NeoBrutalism restyles native SwiftUI controls — `Button`, `Toggle`, `TextField`,
`ProgressView`, `GroupBox`, and more — through their standard style protocols, so you keep
your code, your accessibility, and your behavior. Where SwiftUI has no style protocol to hook
into (`List`, navigation chrome, sliders, radio groups…), NeoBrutalism ships helper modifiers
or drop-in `NB*` views that mirror the native shape.

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

Start with <doc:GettingStarted>, then read <doc:Theming> to customize colors, spacing, and
the five bundled preset themes.

## Topics

### Getting started

- <doc:GettingStarted>
- <doc:Theming>

### Root modifier

- ``SwiftUICore/View/neoBrutalism(theme:applyBackground:)``

### Styles for native controls

- ``NBButtonStyle``
- ``NBCheckboxToggleStyle``
- ``NBSwitchToggleStyle``
- ``NBRadioStyle``
- ``NBInputStyle``
- ``NBProgressViewStyle``
- ``NBGaugeStyle``
- ``NBLabelStyle``
- ``NBLabeledContentStyle``
- ``NBMenuStyle``
- ``NBAccordionDisclosureGroupStyle``
- ``NBControlGroupStyle``
- ``NBGroupBoxStyle``

### Drop-in views

- ``NBSlider``
- ``NBStepper``
- ``NBSegmentedPicker``
- ``NBSegmentItem``
- ``SwiftUICore/View/nbSegment(_:)``
- ``NBRadioGroup``
- ``NBRadioItem``
- ``NBRadioIndicator``
- ``NBTabView``
- ``NBTab``
- ``NBAlert``
- ``NBBadge``
- ``NBCollapsable``
- ``NBCollapsableContent``
- ``NBCollapsibleTrigger``
- ``NBRoundSkeleton``
- ``NBTextSkeleton``
- ``SwiftUICore/View/nbSkeleton(active:)``
- ``NBMenu``
- ``NBMenuItem``
- ``NBSwipeAction``
- ``SwiftUICore/View/nbSwipeActions(edge:allowsFullSwipe:actions:initialOffset:)``
- ``NBAccordion``

### Result builders

- ``NBMenuBuilder``
- ``NBSegmentBuilder``
- ``NBTabBuilder``

### Helpers for List, navigation & more

- ``SwiftUICore/View/nbList()``
- ``SwiftUICore/View/nbListRow(elevated:)``
- ``SwiftUICore/View/nbNavigationBar()``
- ``SwiftUICore/View/nbTextEditor()``
- ``SwiftUICore/View/nbDrawer(isPresented:onDismiss:content:)``
- ``SwiftUICore/View/nbDialog(_:isPresented:actions:message:)``

### Theme

- ``NBTheme``
- ``SwiftUICore/View/nbTheme(_:)``

### Building blocks

- ``SwiftUICore/View/nbBox(elevated:roundedCorners:)``
- ``SwiftUICore/View/nbPressEffect(isPressed:roundedCorners:)``
- ``SwiftUICore/View/nbPressEffect(elevated:isPressed:roundedCorners:)``
- ``NBCornerSet``
- ``AnyEquatable``

### Extensions to system types

- ``SwiftUI``
- ``SwiftUICore``
- ``UIKit``
