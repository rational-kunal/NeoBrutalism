# T09 — Label / LabeledContent style fixes

**Size:** XS · **Depends on:** nothing · **Blocks:** T11 (root modifier can't safely apply these styles until fixed)

## Problems

1. `Components/Label/LabelStyle.swift` hardcodes `.foregroundStyle(theme.text)` on both icon
   and title. A `Label` inside a default (main-colored) Button, Menu, or GroupBox must use
   `theme.mainText`, not `theme.text` — in dark mode `text` is near-white and `main` is a
   light pastel, so the label becomes unreadable. This is exactly the combination the root
   modifier will create, so it must inherit color instead of setting it.
2. `Components/LabeledContent/LabeledContentStyle.swift` colors the value with `theme.main` —
   an accent *surface* color used as text: light-blue-on-white fails contrast in light mode.
   It also bakes in `.padding(.horizontal, theme.padding)`, which double-pads when used
   inside GroupBox/List rows.

## Changes

1. **NBLabelStyle**: remove both `.foregroundStyle(theme.text)` calls. Keep the
   `HStack(spacing: theme.smspacing)` and `.fontWeight(.bold)` on the title. The label now
   inherits whatever foreground its container sets (buttons set `mainText`/`text` correctly
   already). Update the DocC comment: the style provides weight and spacing; color comes from
   context.
2. **NBLabeledContentStyle**: value foreground `theme.main` → `theme.text`; keep
   `.fontWeight(.bold)` as the differentiator (label stays `.regular`). Remove the
   `.padding(.horizontal, theme.padding)` line — padding belongs to the container.
3. Update both files' `#Preview`s to show the styles inside a default `GroupBox` (colored
   surface) and standalone, proving the inherit behavior.

## Definition of done

- [ ] Re-record `LabelTests` and `LabeledContentTests` (intentional visual change: delete
      those two snapshot folders' stale images first). In the **default light theme** the
      Label pixels are likely identical (text was already black); dark mode and
      LabeledContent will differ — eyeball the new PNGs.
- [ ] Add one snapshot each: `Label` inside a `GroupBox("…"){}.groupBoxStyle(.neoBrutalism())`
      and `LabeledContent` inside a neutral GroupBox — the contrast cases that motivated this.
- [ ] Example app entries updated if they showcased the removed padding.

## Out of scope

Adding the styles to the root modifier (T11 does that); new Label variants (e.g. boxed/badge
labels).
