# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0] - 2026-07-19

The "one modifier" release: `.neoBrutalism()` at the root of your view tree now styles the
whole hierarchy — native controls, drop-in `NB*` views, and layout helpers alike.

This is a **major** release: `NBCard`, `NBFlatCard`, and the old `NBTabs*` views are removed
(see "Upgrading from 2.0.0"). Renamed styles still compile behind deprecation warnings, so most
projects upgrade with no code changes.

### Added

- `.neoBrutalism()` / `.neoBrutalism(theme:)` root modifier — applies every default style
  (button, toggle, text field, progress, label, labeled content, menu, disclosure group,
  control group, group box) to a whole view hierarchy in one call, with an
  `applyBackground:` option to place `theme.background` for you
  ([#33](https://github.com/rational-kunal/NeoBrutalism/pull/33)).
- Native style protocol coverage: `GroupBoxStyle`, `ControlGroupStyle`, `GaugeStyle`,
  `LabelStyle`, `LabeledContentStyle`, and `MenuStyle` (+ `NBMenu` dropdown, later polished
  with divider rows, disabled items, and a scroll cap for long menus —
  [#37](https://github.com/rational-kunal/NeoBrutalism/pull/37)).
- `NBTabView` — inline tab view mirroring native `TabView` + `Tab(_:systemImage:value:)`.
- `NBSegmentedPicker` — segmented `Picker` isn't stylable, so it ships as a drop-in view.
- List & Form support: `nbList()` / `nbListRow()`
  ([#35](https://github.com/rational-kunal/NeoBrutalism/pull/35)).
- `nbNavigationBar()` navigation chrome helper
  ([#30](https://github.com/rational-kunal/NeoBrutalism/pull/30)).
- `nbTextEditor()` helper and verified `SecureField` support
  ([#29](https://github.com/rational-kunal/NeoBrutalism/pull/29)).
- `nbDialog()` — centered modal alert replacement, backed by a new `NBOverlayWindow`
  ([#31](https://github.com/rational-kunal/NeoBrutalism/pull/31)).
- `nbSkeleton()` pulse modifier for loading placeholders
  ([#39](https://github.com/rational-kunal/NeoBrutalism/pull/39)).
- `nbSwipeActions()` — neobrutalist drag-to-reveal swipe row
  ([#41](https://github.com/rational-kunal/NeoBrutalism/pull/41), overflow-at-rest fix
  [#45](https://github.com/rational-kunal/NeoBrutalism/pull/45)).
- `fontDesign` theme token — set a global `Font.Design` via `.neoBrutalism()`
  ([#34](https://github.com/rational-kunal/NeoBrutalism/pull/34)).
- 5 preset themes — `.sunnyPeach`, `.bubblegum`, `.seafoam`, `.tangerine`, `.lavender` —
  each with its own shape, density, and font personality, not just a recolor
  ([#42](https://github.com/rational-kunal/NeoBrutalism/pull/42)); live theme gallery in
  the Example app ([#43](https://github.com/rational-kunal/NeoBrutalism/pull/43)).
- `NBAlert` string-based convenience initializers
  ([#38](https://github.com/rational-kunal/NeoBrutalism/pull/38)).
- Radio: accessibility labels/values/traits, no more nested `Button`
  ([#24](https://github.com/rational-kunal/NeoBrutalism/pull/24)).
- Indeterminate `ProgressView` support, deduplicated bar-meter rendering shared between
  Progress and Gauge ([#23](https://github.com/rational-kunal/NeoBrutalism/pull/23)).
- Disabled-state rendering for all controls
  ([#22](https://github.com/rational-kunal/NeoBrutalism/pull/22)).
- Theme-token color sweep (no more hardcoded blacks) and Reduce Motion support across the
  press effect and skeleton shimmer.

### Changed

- Style naming unified around one `.neoBrutalism` entry point per style protocol, with a
  suffix for named variants (`.neoBrutalismCheckbox`, `.neoBrutalismSwitch`,
  `.neoBrutalismRadio`) ([#32](https://github.com/rational-kunal/NeoBrutalism/pull/32)).
  See "Upgrading from 2.0.0" below.
- One shared press effect (the hard drop shadow collapses flush against the surface) used
  by Button, Checkbox, Switch, Radio, Stepper, ControlGroup, and the Collapsable trigger
  ([#25](https://github.com/rational-kunal/NeoBrutalism/pull/25); fixed to animate
  correctly on quick taps in
  [#46](https://github.com/rational-kunal/NeoBrutalism/pull/46)).
- `NBStepper` v2: configurable step, press-and-hold auto-repeat, adjustable accessibility
  ([#36](https://github.com/rational-kunal/NeoBrutalism/pull/36)).
- `NBSlider` v2: generic `Value`, range, step, accessibility
  ([#40](https://github.com/rational-kunal/NeoBrutalism/pull/40)).
- Label / LabeledContent style fixes (foreground color, contrast)
  ([#28](https://github.com/rational-kunal/NeoBrutalism/pull/28)).
- Example app: Todo is now the first tab with almost no per-view style modifiers besides
  one intentional toggle/button variant; Gallery regrouped into
  Controls/Containers/Feedback/Loading ([#44](https://github.com/rational-kunal/NeoBrutalism/pull/44)).
- Test suite migrated to [pointfree swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing),
  reference simulator pinned to iPhone 16 / iOS 26.2, plus a CI "Re-record snapshots"
  workflow and a unit-test layer
  ([#21](https://github.com/rational-kunal/NeoBrutalism/pull/21)).

### Removed

- `NBCard` and `NBFlatCard` — use native `GroupBox` styled with
  `.groupBoxStyle(.neoBrutalism(type:elevated:))` instead.
- The old bar-style `NBTabs` / `NBTabsList` / `NBTabsTrigger` / `NBTabsContent` — replaced by
  `NBTabView`.
- The empty `NB` namespace struct.
- Folder-name typos fixed: `Accordian` → `Accordion`, `Checbox` → `Checkbox` (directory
  names only — no public symbol changed)
  ([#26](https://github.com/rational-kunal/NeoBrutalism/pull/26)).

### Deprecated

Renamed in 3.0.0; the old names still compile with an `@available(*, deprecated)` warning
and will not be removed before v4.0.

- `.neoBrutalismChecklist` (`ToggleStyle`) → renamed `.neoBrutalismCheckbox`.
- `.neoBrutalismAccordion` (`DisclosureGroupStyle`) → renamed `.neoBrutalism`.
- `NBAccordion` view → use `DisclosureGroup` styled with
  `.disclosureGroupStyle(.neoBrutalism)`.

### Fixed

- `nbSwipeActions` tile overflow at rest
  ([#45](https://github.com/rational-kunal/NeoBrutalism/pull/45)).
- Press effect not animating on quick taps
  ([#46](https://github.com/rational-kunal/NeoBrutalism/pull/46)).
- Border stroke color now consistently matches the theme border color
  ([#8](https://github.com/rational-kunal/NeoBrutalism/pull/8)).

## Upgrading from 2.0.0

3.0.0 is a major release. The types below were **removed** and need a one-line migration to
compile; everything else was **deprecated** and still compiles (with a warning) until at
least v4.0.

**Removed — update these to compile:**

| Removed | Replacement |
|---|---|
| `NBCard` / `NBFlatCard` | `GroupBox` + `.groupBoxStyle(.neoBrutalism(type:elevated:))` |
| `NBTabs` / `NBTabsList` / `NBTabsTrigger` / `NBTabsContent` | `NBTabView` |
| `NB` (empty namespace) | — |

**Deprecated — still compile, migrate at your own pace:**

| Deprecated | Replacement |
|---|---|
| `.toggleStyle(.neoBrutalismChecklist)` | `.toggleStyle(.neoBrutalismCheckbox)` |
| `.disclosureGroupStyle(.neoBrutalismAccordion)` | `.disclosureGroupStyle(.neoBrutalism)` |
| `NBAccordion` | `DisclosureGroup` + `.disclosureGroupStyle(.neoBrutalism)` |

## [2.0.0] - 2025-05-11

Initial tagged releases predate this changelog. See `git log 1.0.0..2.0.0` for detail.

[Unreleased]: https://github.com/rational-kunal/NeoBrutalism/compare/3.0.0...HEAD
[3.0.0]: https://github.com/rational-kunal/NeoBrutalism/compare/2.0.0...3.0.0
[2.0.0]: https://github.com/rational-kunal/NeoBrutalism/releases/tag/2.0.0
