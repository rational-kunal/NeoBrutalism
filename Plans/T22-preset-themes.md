# T22 — Ship 5 preset themes

**Size:** S · **Depends on:** nothing (T15 optional: presets may set `fontDesign`)

## Goal

Bold color is the heart of neobrutalism, yet the library ships only `.default` (blue). Ship
five named presets so "try a different look" is one argument change:
`.neoBrutalism(theme: .bubblegum)`. This is also what makes README/screenshot material pop.

## Changes

1. New file `Sources/NeoBrutalism/Common/Theme+Presets.swift` with a `public extension NBTheme`.
2. **Move `sunnyPeach`** from `Example/Sources/Theme+.swift` into the library verbatim (keep
   the name — it's already public in the wild via the Example). Delete the Example copy and
   import it from the package instead.
3. Add four more, following `sunnyPeach`'s exact `updateBy`-from-`.default` pattern. Values
   (chosen to match the neobrutalism.dev accent palette; light `background` is a soft tint of
   `main`; dark `background`/`bw` reuse `.default`'s):

   | Preset | `main` | light `background` |
   |---|---|---|
   | `bubblegum` | `rgb(1.0, 0.651, 0.965)` /* #FFA6F6 */ | `rgb(0.984, 0.929, 0.984)` |
   | `seafoam` | `rgb(0.639, 0.902, 0.212)` /* #A3E636 */ | `rgb(0.929, 0.969, 0.863)` |
   | `tangerine` | `rgb(0.992, 0.592, 0.271)` /* #FD9745 */ | `rgb(0.992, 0.941, 0.894)` |
   | `lavender` | `rgb(0.639, 0.533, 0.933)` /* #A388EE */ | `rgb(0.941, 0.922, 0.984)` |

   For all four: `mainText` stays black in both modes (pastel mains need dark text);
   `text`/`border`/`bw`/`blank`/`overlay` inherit `.default`. Each preset gets a DocC comment
   with its hex values, e.g. `/// Pink accent (#FFA6F6) on a blush background.`
4. If the final rendered pair looks off in the snapshot review (contrast, muddiness), adjust
   the background tint — the table is the starting point, the recorded snapshot is the
   decision.
5. `#Preview` in the new file: one representative card+button+toggle cluster per theme,
   stacked, so all five are eyeballable side by side.

## Tests

New `ThemePresetTests.swift`: for **each** preset, one compact composite snapshot (GroupBox
containing a Button, a Toggle, a Badge, wrapped in `.neoBrutalism(theme: preset, applyBackground: true)`
— use the root modifier if T11 landed, otherwise apply styles directly). Ten images
(5 × light/dark) — enough to lock the palettes without exploding CI time.

## Definition of done

- [ ] `Example` builds with the library `sunnyPeach` (its local copy deleted).
- [ ] All preset snapshots recorded via the CI workflow and **visually reviewed** — this task
      is 50% taste;
      the reviewer instruction is: black text must be comfortably readable on every `main`,
      and `bw` cards must stand out against every `background`, in both modes.
- [ ] README Theming section lists the presets (a table of name → swatch can wait for T25's
      screenshots).

## Out of scope

A theme *builder* API; semantic tokens; per-preset `fontDesign` (leave nil unless one
obviously sings).
