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

Current release: **3.0.0** · iOS 17+

> **Execution:** each roadmap item is broken into implementation-ready, single-session task
> specs in [`Plans/`](Plans/README.md).

---

## Milestone 1 — Out of the box ✅ (shipped in 3.0.0)

Goal: a new user gets the full neobrutalism look with **one modifier at the root of
their view tree** — no per-control styling required.

### The one-line entry point
- [x] `.neoBrutalism()` root modifier — injects the theme *and* applies every default
      style (`buttonStyle`, `toggleStyle`, `textFieldStyle`, `progressViewStyle`,
      `disclosureGroupStyle`, plus new ones below) to the whole hierarchy in one call.
      This is the headline feature; everything else in this milestone feeds it.
- [x] `.neoBrutalism(theme:)` variant to pass a custom theme in the same call.
- [x] Background handling — `.neoBrutalism(applyBackground: true)` places
      `theme.background` for you, so the "How to use" example becomes two lines.

### Finish native style coverage
Done already: ✅ Button · ✅ Checkbox/Switch (`ToggleStyle`) · ✅ TextField ·
✅ ProgressView · ✅ Accordion (`DisclosureGroupStyle`)

Each new style follows the same definition of done (docs + previews + snapshots + README):
- [x] `GroupBoxStyle` — native `GroupBox` gets the Card look for free
- [x] `LabelStyle` — icon + text in theme style
- [x] `GaugeStyle` — bordered dial/meter; a natural fit for the style
- [x] `ControlGroupStyle` — bordered button group
- [x] `MenuStyle` — neobrutalist dropdown menu
- [x] `LabeledContentStyle` — settings-row style label/value pairs
- [ ] Paged `TabView` page indicator — gives us a carousel for free (not yet; `NBTabView`
      ships inline tabs, not a paged carousel)

### Native controls with no open style protocol
SwiftUI doesn't let us style these via a protocol, so we mirror the native API with a
drop-in view (same initializer shape, so migration is a rename):
- [x] `NBStepper` — mirrors `Stepper`
- [x] `NBSegmentedPicker` — segmented `Picker` is not stylable

### Design consistency
- [x] One shared press effect (shadow collapses, content translates by the shadow
      offset) used by Button, Checkbox, Switch, Radio, Stepper, ControlGroup, Collapsable trigger.
- [x] Respect Reduce Motion in the press effect and skeleton shimmer.

---

## Milestone 2 — Production ready (v3.0+)

Goal: a team can adopt this in a shipping app and trust it. The breaking API audit shipped
in **3.0.0**; the remaining production-hardening (performance, macOS, deeper accessibility)
continues in 3.x.

### API audit (breaking, done in 3.0.0)
- [x] Consistent style naming — one `.neoBrutalism` entry point per protocol, suffixed
      variants (`.neoBrutalismCheckbox` / `.neoBrutalismSwitch` / `.neoBrutalismRadio`);
      old names deprecated.
- [x] Resolve duplication between `NBButton` and `.buttonStyle(.neoBrutalism())` —
      only the `NBButtonStyle` style ships; there is no separate `NBButton` view.
- [ ] Review the whole public surface: what's `public` today that shouldn't be?
      (e.g. the `UIColor`/`Color` helpers in Theme.swift leak into consumers' namespace).
- [x] Rename internals with typos (`Accordian/`, `Checbox/`) while nothing external
      depends on file layout.

### Accessibility
- [ ] VoiceOver labels/values/traits for the custom-gesture components: Slider, Radio,
      Tabs, Collapsable, Drawer (native-styled controls already inherit this). *Slider and
      Radio done (T17/T05); the rest remain.*
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
- [x] DocC catalog: Getting Started, Theming guide, component gallery; CI `docbuild`
      guard. Hosting on Swift Package Index is the remaining maintainer step (see Adoption).
- [x] `CHANGELOG.md`, kept from 3.0 onward.
- [x] `CONTRIBUTING.md` — moved the "how to build a component" guide there.
- [x] CI: snapshot tests on every PR + DocC build check. *(SwiftFormat/SwiftLint
      deliberately deferred — reformatting every file would pollute blame; see T27.)*

---

## Milestone 3 — Custom components (post-3.0, demand-driven)

Only components with no native counterpart. Ship in small releases; pick by what real
apps (Example app, Mismatch, community requests) actually need next.

**Quick wins** — Avatar · Toast/Snackbar · ~~Dialog/Modal~~ (`nbDialog`, shipped) · Chip/Tag · Tooltip
**Medium** — Select/Dropdown · Rating (stars) · Pagination · Breadcrumb
**Large** — Calendar/DatePicker · Table/data grid · Image Card

---

## Milestone 4 — Theming as a feature ✅ (shipped in 3.0.0)

- [x] Ship 3–4 bold preset themes — shipped 5 (`.sunnyPeach`, `.bubblegum`, `.seafoam`,
      `.tangerine`, `.lavender`), each with its own shape, density, and font personality,
      not just a recolor (T22).
- [x] Theme gallery in the Example app with live switching (T23).
- [x] Document how to build a theme from scratch (README "Theming" section).

---

## Adoption (ongoing, parallel to all milestones)

- [ ] Add the package to the [Swift Package Index](https://swiftpackageindex.com)
      with hosted DocC and platform-compatibility badges — `.spi.yml` is in the repo;
      the PackageList PR is the remaining maintainer action (T26).
- [x] README hero: an animated GIF of the Example app (`docs/media/demo.gif`, T25) —
      motion sells this style far better than screenshots.
- [ ] Publish the Example app to TestFlight so people can feel the components (needs a
      paid dev account — optional).
- [ ] Write build-log articles: "Restyling native SwiftUI controls with style protocols".
      Canonical home is the author's [writings](https://github.com/rational-kunal/writings)
      repo (cross-post to dev.to with a canonical link); outline drafted in
      [`docs/launch/article.md`](docs/launch/article.md).
- [ ] Submit to iOS Dev Weekly, awesome-swiftui / awesome-ios lists, r/SwiftUI,
      Show HN, X/Mastodon with #SwiftUI — post copy and exact submission URLs drafted in
      [`docs/launch/`](docs/launch/) (`announcement.md` + `checklist.md`).
- [ ] Ask neobrutalism.dev (the design credit) to link this as the SwiftUI port (T28).
- [ ] Label `good first issue`s so the component backlog attracts contributors (T28).
- [ ] Keep "apps built with NeoBrutalism" in the README (Mismatch today) and grow it.

---

Looking to contribute? See [CONTRIBUTING.md](CONTRIBUTING.md) for dev setup, how to build a
new component, and the PR checklist.
