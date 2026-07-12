# T17 — NBSlider v2: generic value, range, step, accessibility

**Size:** M · **Depends on:** T03 (disabled effect)

## Goal

`NBSlider` (`Sources/NeoBrutalism/Components/Slider.swift`) only accepts
`Binding<CGFloat>` in 0…1 — it is not a drop-in for `Slider(value:in:step:)`, which defeats
the "migration is a rename" principle. It also has no accessibility support and a thumb whose
touch target is ~16pt.

## Target API (mirrors native `Slider`)

```swift
public struct NBSlider<V: BinaryFloatingPoint>: View where V.Stride: BinaryFloatingPoint {
    /// Creates a neobrutalism slider.
    /// - Parameters:
    ///   - value: The value being adjusted.
    ///   - bounds: The range of valid values. Defaults to `0...1`.
    ///   - step: Optional increment to snap to.
    ///   - onEditingChanged: Called with `true` when the drag begins, `false` when it ends.
    public init(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        step: V.Stride? = nil,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    )
}
```

Existing call sites (`NBSlider(value: $someCGFloat)`) keep compiling because `CGFloat`
conforms to `BinaryFloatingPoint` and every new parameter is defaulted — verify the Example
app builds unchanged.

## Behavior spec

- Internally normalize to a 0…1 `fraction` for layout; convert on read/write. When `step` is
  set, snap the written value to the nearest step (and snap the drawn fraction so track and
  value agree).
- Keep the current visual construction (track `HStack` + `.nbBox(elevated: false)` + circle
  thumb) with two fixes:
  - **Thumb travel**: inset by half the thumb width so the thumb stays inside the track ends
    (today at 0 and 1 it hangs half-off).
  - **Touch target**: give the thumb `.frame(width: 44, height: 44).contentShape(Circle())`
    around the visible circle so it's draggable by Apple's minimum target size. Also allow
    drags starting anywhere on the track (current behavior already does — keep it).
- `onEditingChanged(true)` on first `onChanged` of a drag, `(false)` in `onEnded` — track
  with a `@State private var isDragging`.
- **Accessibility**:
  ```swift
  .accessibilityRepresentation {
      Slider(value: …, in: …)   // native representation gets adjustable semantics for free
  }
  ```
  — or if that fights the generic types, fall back to `.accessibilityElement()` +
  `.accessibilityValue` + `.accessibilityAdjustableAction` stepping by `step ?? span/10`.
- `.nbDisabledEffect()` on the outer view (from T03) and no value changes while disabled.

## Tests + example

- `SliderTests`: existing snapshots must pass without re-recording **if** the thumb-inset fix
  is snapshot-visible — it will be (0.0/1.0 cases). Expected: re-record `slider` suite via the
  CI "Re-record snapshots" workflow (README "Verification"); eyeball that 0 and 1 now sit flush
  inside the track.
- New snapshots: `in: 0...100` with step, disabled.
- Example app: replace the CGFloat example with `@State var volume: Double = 30` +
  `NBSlider(value: $volume, in: 0...100, step: 5)`.

## Definition of done

- [ ] Old one-argument init compiles untouched (Example builds before any Example edits).
- [ ] VoiceOver: element reads as adjustable slider with a sensible value; swipe up/down
      changes it.
- [ ] README Slider section updated to the native-mirroring signature.

## Out of scope

Vertical orientation; min/max labels; tick marks.
