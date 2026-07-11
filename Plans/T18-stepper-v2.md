# T18 — NBStepper v2: step, auto-repeat, accessibility

**Size:** S · **Depends on:** T03, T06 (both touch this file; land after them)

## Goal

`Sources/NeoBrutalism/Components/Stepper/NBStepper.swift` handles only `Int` with implicit
step 1, has no press-and-hold repeat (native steppers repeat), and exposes two separate
buttons to VoiceOver instead of one adjustable element.

## Changes

1. **`step` parameter** (additive, defaulted):
   ```swift
   public init(value: Binding<Int>, in range: ClosedRange<Int>, step: Int = 1, @ViewBuilder label: () -> Label)
   init(_ title: String, value: Binding<Int>, in range: ClosedRange<Int>, step: Int = 1)  // Text convenience
   ```
   Increment/decrement clamp into `range` (e.g. value 9, step 5, max 10 → goes to 10).
2. **Auto-repeat on long press**: while a +/– button is held past 0.5s, repeat the step every
   0.15s. Implement with the existing `DragGesture(minimumDistance: 0)` press tracking: on
   press start, schedule a repeating `Timer` (store in `@State`); cancel in `onEnded`. Stop at
   range bounds. Respect nothing motion-related (no animation involved beyond the existing
   press effect).
3. **Accessibility** — one adjustable element:
   ```swift
   .accessibilityElement(children: .ignore)
   .accessibilityLabel(/* the label text — accept an optional explicit string, else "Stepper" */)
   .accessibilityValue("\(value)")
   .accessibilityAdjustableAction { direction in
       switch direction {
       case .increment: increment()
       case .decrement: decrement()
       @unknown default: break
       }
   }
   ```
   Extract `increment()`/`decrement()` private funcs so buttons, repeat timer, and a11y share
   one code path.
4. Keep visuals byte-identical (T06 already unified the press effect here).

## Definition of done

- [ ] Existing `StepperTests` snapshots pass without re-recording; add one snapshot with a
      wide value (`value: 100, in: 0...1000`) to lock the min-width behavior.
- [ ] Simulator check: hold + → value climbs, stops at max.
- [ ] VoiceOver: single element, adjustable, announces value changes.
- [ ] README/Example updated for `step:`.

## Out of scope

Generic `Strideable` values (breaking-ish and rarely needed — record as a v3.0 candidate in
the PR); editable center value (tap-to-type).
