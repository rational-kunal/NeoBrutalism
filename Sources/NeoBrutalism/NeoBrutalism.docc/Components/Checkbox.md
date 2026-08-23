# Checkbox

A boxed check mark for opting in — a `Toggle` wearing a different style.

## Overview

One modifier turns a `Toggle` into a checkbox:

```swift
Toggle("Remember me", isOn: $rememberMe)
    .toggleStyle(.neoBrutalismCheckbox)
```

![A checked neobrutalism checkbox with a label](nb-checkbox-label-on)

It's still a `Toggle`, so your binding, VoiceOver, and Dynamic Type all behave as usual.

> Note: A plain `Toggle` is a **switch** — see <doc:Switch>. The checkbox is opt-in per toggle,
> which matches how `Toggle` behaves natively.

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
