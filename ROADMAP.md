# NeoBrutalism — Roadmap

**Vision:** NeoBrutalism should work out of the box. You add the package, apply a view
modifier, and your app — built with plain, native SwiftUI — takes on the neobrutalism
look. Custom `NB*` views exist only where SwiftUI has no native counterpart.

**Principles**
- **Native first.** Style native controls through SwiftUI style protocols
  (`ButtonStyle`, `ToggleStyle`, …) before inventing a custom view. Users keep their
  existing code; we keep accessibility and behavior for free.
- **Zero runtime dependencies.** The library target depends only on SwiftUI.
  (Snapshot-testing dependencies are test-only.)
- **Every public API ships complete:** DocC comment, `#Preview`, light + dark snapshot
  test, README entry, Example app entry.
- **Semver.** Breaking API changes only in major releases.

Current release: **2.0.0** · iOS 17+ · 20 components

> **Execution:** each roadmap item is broken into implementation-ready, single-session task
> specs in [`Plans/`](Plans/README.md).

---

## Milestone 1 — Out of the box (v2.1–v2.x)

Goal: a new user gets the full neobrutalism look with **one modifier at the root of
their view tree** — no per-control styling required.

### The one-line entry point
- [ ] `.neoBrutalism()` root modifier — injects the theme *and* applies every default
      style (`buttonStyle`, `toggleStyle`, `textFieldStyle`, `progressViewStyle`,
      `disclosureGroupStyle`, plus new ones below) to the whole hierarchy in one call.
      This is the headline feature; everything else in this milestone feeds it.
- [ ] `.neoBrutalism(theme:)` variant to pass a custom theme in the same call.
- [ ] Background handling — today users must place `theme.background` themselves;
      the root modifier should offer it (`.neoBrutalism(applyBackground: true)` or
      similar) so the "How to use" example becomes two lines.

### Finish native style coverage
Done already: ✅ Button · ✅ Checkbox/Switch (`ToggleStyle`) · ✅ TextField ·
✅ ProgressView · ✅ Accordion (`DisclosureGroupStyle`)

Each new style follows the same definition of done (docs + previews + snapshots + README):
- [x] `GroupBoxStyle` — native `GroupBox` gets the Card look for free
- [ ] `LabelStyle` — icon + text in theme style
- [ ] `GaugeStyle` — bordered dial/meter; a natural fit for the style
- [ ] `ControlGroupStyle` — bordered button group
- [ ] `MenuStyle` — neobrutalist dropdown menu
- [ ] `LabeledContentStyle` — settings-row style label/value pairs
- [ ] Paged `TabView` page indicator — gives us a carousel for free

### Native controls with no open style protocol
SwiftUI doesn't let us style these via a protocol, so we mirror the native API with a
drop-in view (same initializer shape, so migration is a rename):
- [ ] `NBStepper` — mirrors `Stepper`
- [ ] `NBSegmentedPicker` — segmented `Picker` is not stylable

### Design consistency
- [ ] One shared press effect (shadow collapses, content translates by the shadow
      offset) used by Button, Checkbox, Switch, Radio, Tabs, Collapsable trigger.
- [ ] Respect Reduce Motion in the press effect and skeleton shimmer.

---

## Milestone 2 — Production ready (v3.0)

Goal: a team can adopt this in a shipping app and trust it. The API audit is breaking,
so this is the 3.0 release.

### API audit (breaking, do once)
- [ ] Consistent style naming — decide one convention for
      `.neoBrutalism` / `.neoBrutalismChecklist` / `.neoBrutalismSwitch` /
      `.neoBrutalismAccordion` and stick to it.
- [ ] Resolve duplication between `NBButton` and `.buttonStyle(.neoBrutalism())` —
      keep one, deprecate the other.
- [ ] Review the whole public surface: what's `public` today that shouldn't be?
      (e.g. the `UIColor`/`Color` helpers in Theme.swift leak into consumers' namespace).
- [ ] Rename internals with typos (`Accordian/`, `Checbox/`) while nothing external
      depends on file layout.

### Accessibility
- [ ] VoiceOver labels/values/traits for the custom-gesture components: Slider, Radio,
      Tabs, Collapsable, Drawer (native-styled controls already inherit this).
- [ ] Dynamic Type — verify components scale; decide whether theme size tokens scale
      with the user's text size.
- [ ] Contrast check on the default theme in light and dark.

### Performance & efficiency
- [ ] Profile a scroll view with 100+ NB components; fix redraw hot spots.
- [ ] Audit `NBBoxModifier` — it's on every component, so its shadow + overlay cost
      is the library's baseline cost.
- [ ] No `AnyView` in hot paths; add `Equatable` where it measurably helps.
- [ ] Confirm the library adds no observable app-launch or first-frame cost.

### Platforms
- [ ] macOS — the blocker is `UIColor` in Theme.swift; replace with a
      platform-neutral color abstraction. Everything else is mostly `#if os` details.
- [ ] visionOS / Mac Catalyst — verify after macOS lands; likely near-free.

### Docs & trust signals
- [ ] DocC catalog: Getting Started, Theming guide (what every token controls, with an
      annotated diagram), component gallery. Host on Swift Package Index.
- [ ] `CHANGELOG.md`, kept from 3.0 onward.
- [ ] `CONTRIBUTING.md` — move the "how to build a component" guide there (kept below
      until then).
- [ ] CI: snapshot tests on every PR, swiftformat/swiftlint check, DocC build check.

---

## Milestone 3 — Custom components (post-3.0, demand-driven)

Only components with no native counterpart. Ship in small releases; pick by what real
apps (Example app, Mismatch, community requests) actually need next.

**Quick wins** — Avatar · Toast/Snackbar · Dialog/Modal · Chip/Tag · Tooltip
**Medium** — Select/Dropdown · Rating (stars) · Pagination · Breadcrumb
**Large** — Calendar/DatePicker · Table/data grid · Image Card

---

## Milestone 4 — Theming as a feature

- [ ] Ship 3–4 bold preset themes (yellow, pink, green — bold color is the heart of
      neobrutalism); today only `.default` exists.
- [ ] Theme gallery in the Example app with live switching.
- [ ] Document how to build a theme from scratch.

---

## Adoption (ongoing, parallel to all milestones)

- [ ] Add the package to the [Swift Package Index](https://swiftpackageindex.com)
      with hosted DocC and platform-compatibility badges.
- [x] README hero: an animated GIF of the Example app (`docs/media/demo.gif`, T25) —
      motion sells this style far better than screenshots.
- [ ] Publish the Example app to TestFlight so people can feel the components.
- [ ] Write build-log articles (personal blog / dev.to): "Restyling native SwiftUI
      controls with style protocols" — teaches something real, markets the library.
- [ ] Submit to iOS Dev Weekly, awesome-swiftui / awesome-ios lists, r/SwiftUI,
      Show HN, X/Mastodon with #SwiftUI.
- [ ] Ask neobrutalism.dev (the design credit) to link this as the SwiftUI port.
- [ ] Label `good first issue`s so the component backlog attracts contributors.
- [ ] Keep "apps built with NeoBrutalism" in the README (Mismatch today) and grow it.

---

Looking to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md) for dev setup, how to build a
new component, and the PR checklist.
