# Switch

The default `Toggle` look — a sliding thumb in a bordered track.

## Overview

A `Toggle` needs nothing from you — the switch is what you get by default:

```swift
Toggle("Shield Charm", isOn: $shieldOn)
```

![A neobrutalism switch in the on position with a label](nb-switch-label-on)

For the boxed check mark instead, see <doc:Checkbox>.

## States

```swift
Toggle(isOn: .constant(true)) {}
Toggle(isOn: .constant(false)) {}
```

![A switch in the on position](nb-switch-on)

![A switch in the off position](nb-switch-off)

The thumb uses the theme's `blank` token rather than `bw`, so it stays visible against the
accent fill in dark mode as well as light. See <doc:Theming> for why those two tokens differ.

## Disabled

```swift
Toggle("Shield Charm", isOn: $shieldOn)
    .disabled(true)
```

![A disabled switch in the on position](nb-switch-disabled)

## Styling it directly

You rarely need this. Apply ``NBSwitchToggleStyle`` when a `Toggle` sits outside the root
modifier's reach, or to force the switch look where a nearer `.neoBrutalismCheckbox` would
otherwise win:

```swift
Toggle("Shield Charm", isOn: $shieldOn)
    .toggleStyle(.neoBrutalismSwitch)
```

## Topics

### Style

- ``NBSwitchToggleStyle``

## See Also

- <doc:Checkbox>
