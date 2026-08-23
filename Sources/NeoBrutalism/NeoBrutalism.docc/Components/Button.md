# Button

A thick-bordered, hard-shadowed button that presses into the page.

## Overview

`Button` is styled automatically by ``SwiftUICore/View/neoBrutalism(theme:applyBackground:)``, so
most screens need nothing at all:

```swift
Button("Cast Spell") {}
```

![A default neobrutalism button](nb-button-default)

To style one button on its own — or to pick a type or variant — apply
``NBButtonStyle`` directly:

```swift
Button("Cast Spell") {}
    .buttonStyle(.neoBrutalism())
```

## Types

`type:` picks the fill. `.default` uses the theme's accent (`main`); `.neutral` uses the plain
surface (`bw`) for secondary actions that shouldn't compete for attention.

```swift
Button("Default") {}
    .buttonStyle(.neoBrutalism())

Button("Neutral") {}
    .buttonStyle(.neoBrutalism(type: .neutral))
```

![An accent-filled default button](nb-button-default)

![A neutral, surface-filled button](nb-button-neutral)

## Shadow variants

`variant:` controls how the button carries the signature drop shadow.

| Variant | Behavior |
|---|---|
| `.default` | Sits raised, and presses down into the shadow when tapped. |
| `.reverse` | Starts flush and lifts *out* on press — the inverse motion. |
| `.noShadow` | Flat. Border only, no shadow, no travel. |

```swift
Button("Reverse") {}
    .buttonStyle(.neoBrutalism(variant: .reverse))

Button("No Shadow") {}
    .buttonStyle(.neoBrutalism(variant: .noShadow))
```

![A button using the reverse shadow variant](nb-button-reverse)

![A button with the shadow removed](nb-button-noshadow)

Types and variants combine freely:

```swift
Button("Neutral Reverse") {}
    .buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
```

![A neutral button using the reverse variant](nb-button-neutral-reverse)

![A neutral button with no shadow](nb-button-neutral-noshadow)

## Labels

Any label works — the style only supplies the chrome, so `Label`, stacks, and multi-line text
lay out the way they normally would.

```swift
Button {} label: {
    Label("With Icon", systemImage: "star.fill")
}
.buttonStyle(.neoBrutalism())
```

![A button whose label pairs a star icon with text](nb-button-icon)

## Disabled

`.disabled(true)` dims the button and drops its shadow, so an unavailable action reads as flat
rather than pressable.

```swift
Button("Disabled") {}
    .buttonStyle(.neoBrutalism())
    .disabled(true)
```

![A disabled button, dimmed and flat](nb-button-disabled)

## Topics

### Style

- ``NBButtonStyle``
