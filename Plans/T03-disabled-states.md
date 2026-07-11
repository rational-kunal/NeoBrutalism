# T03 — Disabled-state rendering for all controls

**Size:** S · **Depends on:** nothing

## Goal

`.disabled(true)` currently blocks interaction but (except for `NBInputStyle`) leaves controls
looking fully active — the Example app even shows disabled checkboxes that look enabled. Add
one shared dimming treatment and apply it to every interactive component.

## Design

Disabled = 50% opacity on the whole control, matching what `NBInputStyle` already does. One
internal modifier so the value can never drift per-component:

```swift
// New file: Sources/NeoBrutalism/Common/NBDisabledEffect.swift
import SwiftUI

/// Dims a control when `isEnabled` is false in the environment.
/// One shared treatment so every component fades the same way.
struct NBDisabledEffect: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content.opacity(isEnabled ? 1.0 : 0.5)
    }
}

extension View {
    func nbDisabledEffect() -> some View {
        modifier(NBDisabledEffect())
    }
}
```

Keep it `internal` (not `public`) — consumers use `.disabled(_:)` as usual.

## Apply to

Append `.nbDisabledEffect()` as the outermost modifier of the control's body in:

| File | Where |
|---|---|
| `Components/Button.swift` | end of `makeBody` chain |
| `Components/Checbox/Checkbox.swift` | on the `Button` in `makeBody` |
| `Components/Switch/Switch.swift` | on the `Button` in `makeBody` |
| `Components/Radio/RadioStyle.swift` | on the `Button` in `makeBody` |
| `Components/Radio/RadioItem.swift` | end of the `HStack` chain |
| `Components/SegmentedPicker/NBSegmentedPicker.swift` | on the outer `HStack` (after `.nbBox()`) |
| `Components/Tabs/NBTabView.swift` | on `triggerList` |
| `Components/Stepper/NBStepper.swift` | on the outer `HStack` (keep the existing per-button range-limit opacity) |
| `Components/Slider.swift` | on the outer `VStack` |
| `Components/Input.swift` | replace the hand-rolled `.opacity(isEnabled ? 1.0 : 0.5)` with `.nbDisabledEffect()`, drop its now-unused `isEnabled` property |

`NBMenu`'s trigger uses `NBButtonStyle`, so it inherits the treatment — just verify.

Also verify (manually in a preview) that `.disabled(true)` blocks `NBSlider`'s `DragGesture`
and `NBRadioItem`'s `onTapGesture`; if a gesture still fires, gate its handler on
`@Environment(\.isEnabled)`.

## Definition of done

- [ ] Disabled snapshot test added per control it's cheap for — at minimum: one disabled
      variant in `ButtonTests`, `CheckboxTests`, `SwitchTests`, `SliderTests`, `StepperTests`,
      `SegmentedPickerTests` (follow the existing pattern in those files: a
      `@SnapshotTest` func returning the view + `.disabled(true)` + `.prettifyForTest()`).
- [ ] New snapshots recorded (run once to record, again to verify). Existing snapshots
      unchanged.
- [ ] Example app: the existing disabled toggles in `CheckboxExampleView` /
      `SwitchExampleView` now visibly dim (eyeball check).

## Out of scope

Disabled styling for non-interactive views (Badge, Alert, skeletons); focus states.
