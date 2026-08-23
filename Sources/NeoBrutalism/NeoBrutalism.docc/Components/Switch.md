# Switch

The default `Toggle` look — a sliding thumb in a bordered track.

## Overview

``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` styles every `Toggle` as a switch, so
this needs no per-view modifier:

```swift
Toggle("Shield Charm", isOn: $shieldOn)
```

![A neobrutalism switch in the on position with a label](nb-switch-label-on)

Apply ``NBSwitchToggleStyle`` explicitly when you want a switch inside a subtree that isn't
covered by the root modifier, or to override a nearer `.neoBrutalismCheckbox`:

```swift
Toggle("Shield Charm", isOn: $shieldOn)
    .toggleStyle(.neoBrutalismSwitch)
```

## States

```swift
Toggle(isOn: .constant(true)) {}
    .toggleStyle(.neoBrutalismSwitch)

Toggle(isOn: .constant(false)) {}
    .toggleStyle(.neoBrutalismSwitch)
```

![A switch in the on position](nb-switch-on)

![A switch in the off position](nb-switch-off)

The thumb uses the theme's `blank` token rather than `bw`, so it stays visible against the
accent fill in dark mode as well as light. See <doc:Theming> for why those two tokens differ.

## Disabled

```swift
Toggle("Shield Charm", isOn: .constant(true))
    .toggleStyle(.neoBrutalismSwitch)
    .disabled(true)
```

![A disabled switch in the on position](nb-switch-disabled)

## Topics

### Style

- ``NBSwitchToggleStyle``

## See Also

- <doc:Checkbox>
