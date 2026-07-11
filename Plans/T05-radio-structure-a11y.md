# T05 — Radio: remove nested button, add accessibility

**Size:** S · **Depends on:** nothing · Relates to GitHub issue #9 (referenced by a TODO in RadioStyle.swift)

## Problems

1. `Components/Radio/RadioStyle.swift` — `makeBody` wraps the row in a `Button`, and its
   private `makeRadio(configuration:)` wraps the indicator in **another** `Button`. A button
   inside a button: double activation targets and confusing VoiceOver output.
2. `Components/Radio/RadioItem.swift` — uses `onTapGesture`, so VoiceOver users get a plain
   text element: no button trait, no selected state, not activatable.
3. `NBRadioGroup` exposes no group semantics.

## Changes

1. **RadioStyle.swift**: `makeRadio` must return just the indicator view
   (`NBRadioIndicator(selected: configuration.isOn)`), not a `Button`. The outer `Button` in
   `makeBody` stays and remains the only tap target.
2. **RadioItem.swift**: replace the `HStack + .contentShape + .onTapGesture` body with a
   `Button` (style `.plain`) whose action runs the existing
   `withAnimation(nbPressAnimation(...)) { radioItemDidSelect(value) }` and whose label is the
   existing `HStack(spacing: theme.smspacing) { NBRadioIndicator(...); label }`. Then add:
   ```swift
   .accessibilityAddTraits(selected ? [.isSelected] : [])
   ```
3. **Radio.swift** (`NBRadioGroup`): mark the container
   ```swift
   .accessibilityElement(children: .contain)
   ```
   so assistive tech perceives one group of options.
4. Both toggle-style and item flows keep the exact current visuals (indicator dot stays
   `theme.text` — that matches the reference design, where the dot follows the text color).

## Definition of done

- [ ] `RadioTests` snapshots pass **without re-recording** (visuals unchanged).
- [ ] Manual VoiceOver check in the Example app (or Accessibility Inspector on a preview):
      each item reads as a button, the chosen one reads "selected", and activating an item
      moves the selection.
- [ ] The `// TODO: https://github.com/rational-kunal/NeoBrutalism/issues/9` comment in
      RadioStyle.swift is resolved or updated to say what remains.

## Out of scope

Making `NBRadioGroup` generic over `Value` instead of `AnyEquatable` (defer to the v3.0 API
audit — it's a breaking change); keyboard focus navigation.
