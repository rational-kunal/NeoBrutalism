# Checkbox

A boxed check mark for opting in — a `Toggle` wearing a different style.

## Overview

A checkbox is a standard SwiftUI `Toggle` with ``NBCheckboxToggleStyle`` applied. It stays a
`Toggle`, so bindings, VoiceOver, and Dynamic Type behave exactly as they always do.

```swift
Toggle("Remember me", isOn: $rememberMe)
    .toggleStyle(.neoBrutalismCheckbox)
```

![A checked neobrutalism checkbox with a label](nb-checkbox-label-on)

> Note: The root modifier styles `Toggle` as a **switch**, matching native semantics. The
> checkbox is opt-in per toggle — see <doc:Switch> for the default.

## States

```swift
Toggle(isOn: .constant(true)) {}
    .toggleStyle(.neoBrutalismCheckbox)

Toggle(isOn: .constant(false)) {}
    .toggleStyle(.neoBrutalismCheckbox)
```

![A checked checkbox with no label](nb-checkbox-on)

![An unchecked checkbox with no label](nb-checkbox-off)

## Labels

Pass any view as the label; an empty label renders the box alone, which is what you want inside
a list row or next to your own text.

![An unchecked checkbox with a text label](nb-checkbox-label-off)

## Disabled

```swift
Toggle("Remember me", isOn: .constant(true))
    .toggleStyle(.neoBrutalismCheckbox)
    .disabled(true)
```

![A disabled, checked checkbox](nb-checkbox-disabled)

## Topics

### Style

- ``NBCheckboxToggleStyle``

## See Also

- <doc:Switch>
- <doc:Radio>
