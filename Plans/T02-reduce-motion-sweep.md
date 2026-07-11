# T02 — Respect Reduce Motion everywhere

**Size:** XS · **Depends on:** nothing

## Goal

All animations must go through the shared helpers in
`Sources/NeoBrutalism/Common/NBPressEffect.swift` (`nbPressAnimation(reduceMotion:)` /
`nbPopAnimation(reduceMotion:)`), which return `.none` when the user has Reduce Motion on.
Most components already comply (Button, Checkbox, Switch, Radio, Accordion style, TabView,
ControlGroup, NBMenu). Two don't.

## Changes

1. `Sources/NeoBrutalism/Components/SegmentedPicker/NBSegmentedPicker.swift`
   - Add `@Environment(\.accessibilityReduceMotion) private var reduceMotion`.
   - The segment button action uses `withAnimation(.interactiveSpring())` — replace with
     `withAnimation(nbPressAnimation(reduceMotion: reduceMotion))`.
2. `Sources/NeoBrutalism/Components/Stepper/NBStepper.swift`
   - Add the same environment property.
   - Two `.animation(.interactiveSpring(), value: ...)` modifiers — replace the animation with
     `reduceMotion ? .none : .interactiveSpring()` (this is the pattern `NBButtonStyle` uses).

Then audit for stragglers:

```bash
grep -rn "interactiveSpring\|withAnimation\|\.animation(" Sources/NeoBrutalism/ | grep -v "reduceMotion\|nbPressAnimation\|nbPopAnimation\|NBPressEffect.swift"
```

Remaining acceptable hits: the deprecated `NBAccordion` (skip it) and `#Preview` blocks.

## Definition of done

- [x] The grep above shows no unguarded animations in non-deprecated component bodies.
- [x] Build + snapshot tests pass without re-recording (snapshots are static frames; nothing
      visual changes).

## Out of scope

The skeleton shimmer (doesn't exist yet — T20 adds it with Reduce Motion handling built in).
