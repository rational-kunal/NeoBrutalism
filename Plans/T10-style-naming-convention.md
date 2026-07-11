# T10 — Style naming convention: `.neoBrutalism` everywhere

**Size:** S · **Depends on:** nothing · **Blocks:** T11 (root modifier should reference the final names)

## Decision (locked)

One rule: **every style protocol gets a `.neoBrutalism` entry point; named variants get a
suffix.** All old names stay working with a deprecation warning until v3.0 (additive only —
semver-safe).

| Protocol | Today | Target |
|---|---|---|
| `ButtonStyle` | `.neoBrutalism(type:variant:)` | ✅ unchanged |
| `ToggleStyle` | `.neoBrutalismChecklist` | `.neoBrutalismCheckbox` (new) + deprecated alias |
| `ToggleStyle` | `.neoBrutalismSwitch` | ✅ unchanged, **plus** `.neoBrutalism` as an alias for the switch — a restyled `Toggle` should stay a switch, matching native semantics |
| `ToggleStyle` | `.neoBrutalismRadio` | ✅ unchanged |
| `DisclosureGroupStyle` | `.neoBrutalismAccordion` | `.neoBrutalism` (new) + deprecated alias |
| `TextFieldStyle`, `ProgressViewStyle`, `GaugeStyle`, `LabelStyle`, `LabeledContentStyle`, `MenuStyle`, `ControlGroupStyle` | `.neoBrutalism` | ✅ unchanged |
| `GroupBoxStyle` | `.neoBrutalism(type:elevated:)` | ✅ unchanged |

## Changes

1. `Components/Checbox/Checkbox.swift`:
   ```swift
   public extension ToggleStyle where Self == NBCheckboxToggleStyle {
       /// Checkbox look for `Toggle`.
       static var neoBrutalismCheckbox: NBCheckboxToggleStyle { .init() }

       @available(*, deprecated, renamed: "neoBrutalismCheckbox")
       static var neoBrutalismChecklist: NBCheckboxToggleStyle { .init() }
   }
   ```
2. `Components/Switch/Switch.swift`: add
   ```swift
   public extension ToggleStyle where Self == NBSwitchToggleStyle {
       /// The default neobrutalism toggle: a switch, matching native `Toggle` semantics.
       static var neoBrutalism: NBSwitchToggleStyle { .init() }
   }
   ```
3. `Components/Accordian/AccordionDisclosureGroupStyle.swift`: add `.neoBrutalism` static var;
   mark `.neoBrutalismAccordion` `@available(*, deprecated, renamed: "neoBrutalism")`.
4. Migrate all internal call sites (library previews, `Tests/`, `Example/`, `README.md` code
   blocks) to the new names so the project builds warning-free. **Exception:** the root
   modifier (`Common/NeoBrutalismModifier.swift`) currently uses `.neoBrutalismChecklist` —
   change it to the new checkbox name for now; T11 revisits which toggle style the root
   applies.

## Definition of done

- [ ] Build has zero deprecation warnings from library/tests/example code.
- [ ] All snapshot tests pass **without re-recording** (aliases render identically).
- [ ] `README.md` code snippets updated (`neoBrutalismChecklist` appears nowhere).
- [ ] Old names still compile in a scratch file with a deprecation warning (spot-check one).

## Out of scope

Renaming public *types* (`NBCheckboxToggleStyle` etc.), the `NBCollapsable` spelling, or
removing deprecated symbols — all v3.0 audit material.
