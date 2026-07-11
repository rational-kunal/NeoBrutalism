# T01 — Replace hardcoded blacks with theme tokens

**Size:** XS · **Depends on:** nothing

## Goal

Every color in component bodies must come from `@Environment(\.nbTheme)`. Four spots hardcode
black, which breaks any theme that customizes `border` (e.g. a white-border dark theme).

## Changes

1. `Sources/NeoBrutalism/Components/Switch/Switch.swift` — two `.stroke(.black, lineWidth:)`
   calls (the track outline in `makeSwitch` and the knob outline in `makeSwitchShape`).
   Replace `.black` with `theme.border`.
2. `Sources/NeoBrutalism/Components/Skeleton/RoundSkeleton.swift` — the circle overlay strokes
   `Color.black`. Replace with `theme.border`.
3. `Sources/NeoBrutalism/Components/Progress.swift` — the mid-bar divider does
   `.background(Color.black)`. Replace with `theme.border`.
4. `Sources/NeoBrutalism/Components/Gauge/GaugeStyle.swift` — same divider pattern, same fix.

While in those files, also grep the whole target for other literals:

```bash
grep -rn "\.black\|Color\.white\|\.gray" Sources/NeoBrutalism/
```

Fix any further hits in component bodies (deprecated `NBAccordion` may be skipped). Do **not**
touch `Theme.swift` — its rgb literals define the tokens themselves.

## Definition of done

- [ ] `grep -rn "\.black" Sources/NeoBrutalism/Components/` returns nothing.
- [ ] Build passes; snapshot tests pass **without re-recording** — in the default theme
      `border` is already black in both modes, so pixels must not change. A snapshot diff
      means you replaced the wrong thing.

## Out of scope

Adding new tokens, changing any visual appearance, touching tests.
