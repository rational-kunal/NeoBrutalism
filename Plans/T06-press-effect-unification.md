# T06 — One shared press effect everywhere

**Size:** S · **Depends on:** nothing (coordinate with T03: whoever lands second rebases)

## Goal

ROADMAP asks for one shared press treatment: *shadow collapses while pressed*. The modifier
exists (`Common/NBPressEffect.swift`) but three components still hand-roll the same logic.
Route them through the modifier so the animation/response can never drift.

## Changes

1. **Extend the modifier** with the box's corner parameter (needed by ControlGroup) and a
   resolved-elevation variant (needed by Button, whose `ShadowVariant` inverts the rule):

```swift
struct NBPressEffectModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let elevated: Bool          // resolved elevation (usually !isPressed)
    let isPressed: Bool         // drives the animation
    let roundedCorners: NBCornerSet

    func body(content: Content) -> some View {
        content
            .nbBox(elevated: elevated, roundedCorners: roundedCorners)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: isPressed)
    }
}

public extension View {
    /// Standard press effect: elevated at rest, shadow collapses while pressed.
    func nbPressEffect(isPressed: Bool, roundedCorners: NBCornerSet = .all) -> some View {
        modifier(NBPressEffectModifier(elevated: !isPressed, isPressed: isPressed, roundedCorners: roundedCorners))
    }

    /// Press effect with caller-resolved elevation, for styles whose variants invert
    /// or suppress the shadow (e.g. `NBButtonStyle.ShadowVariant.reverse`).
    func nbPressEffect(elevated: Bool, isPressed: Bool, roundedCorners: NBCornerSet = .all) -> some View {
        modifier(NBPressEffectModifier(elevated: elevated, isPressed: isPressed, roundedCorners: roundedCorners))
    }
}
```

2. **Adopt it:**
   - `Components/Button.swift`: replace `.nbBox(elevated: elevated)` + trailing `.animation(...)`
     with `.nbPressEffect(elevated: elevated, isPressed: isPressed)`. Delete the style's own
     `reduceMotion` property if now unused.
   - `Components/Stepper/NBStepper.swift`: replace the two `.animation(...)` lines +
     `.nbBox(elevated: !(isMinusPressed || isPlusPressed))` with
     `.nbPressEffect(isPressed: isMinusPressed || isPlusPressed)`.
   - `Components/ControlGroup/ControlGroupStyle.swift` (`NBControlGroupSectionStyle`): replace
     `.nbBox(roundedCorners: corners)` + `.animation(...)` with
     `.nbPressEffect(isPressed: configuration.isPressed, roundedCorners: corners)`, and remove
     the pressed-darken overlay (`theme.border.opacity(0.15)`) so the pressed section speaks
     the same shadow-collapse language as every other control.

## Definition of done

- [ ] Button, Stepper snapshots pass **without re-recording** (rest-state pixels identical).
- [ ] ControlGroup: re-record its suite (pressed rendering changed by design; rest state
      should still be identical — verify by diffing the old/new PNGs before committing) and
      eyeball the press interaction in the Example app.
- [ ] `grep -rn "interactiveSpring" Sources/NeoBrutalism/Components/` only hits files that
      pass through `nbPressAnimation`/`nbPopAnimation`/`nbPressEffect` (and the deprecated
      `NBAccordion`).

## Out of scope

Changing what "pressed" looks like beyond the ControlGroup overlay removal; haptics.
