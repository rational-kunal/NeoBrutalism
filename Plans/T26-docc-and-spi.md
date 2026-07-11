# T26 — DocC catalog + Swift Package Index

**Size:** M · **Depends on:** T11 (documents the root modifier); article content firms up as
phases land

## Goal

Hosted, browsable docs — the trust signal serious adopters check — via DocC on the Swift
Package Index (free hosting, and SPI listing is itself discovery).

## Part 1 — DocC catalog

New `Sources/NeoBrutalism/NeoBrutalism.docc/` containing:

1. `NeoBrutalism.md` (landing page):
   ```
   # ``NeoBrutalism``

   Neobrutalism design for native SwiftUI — one modifier restyles your app.
   ```
   with `## Topics` groups curating the public surface: *Getting started* (articles below),
   *Root modifier*, *Styles for native controls* (all `NB*Style` types), *Drop-in views*
   (`NBSlider`, `NBStepper`, …), *Theming* (`NBTheme`), *Building blocks* (`nbBox`,
   `nbPressEffect`, corner set).
2. `GettingStarted.md` article: install → `.neoBrutalism()` → what's covered → the helpers
   for List/navigation → linking to the Example app.
3. `Theming.md` article: every token explained with what it controls (adapt the excellent
   doc comments already in `Theme.swift`), `updateBy` recipes, the presets, dark-mode notes
   (border stays black by design; `blank` vs `bw`).
4. Images: reuse `docs/media/` captures via DocC's `Resources/` (keep total size sane —
   compress PNGs).
5. Every public symbol already lacking a doc comment gets at least a one-liner (audit:
   `NBBadge`, `NBAlert`, `NBRadioGroup`, skeletons, `NBCornerSet`, `nbBox`, drawer — several
   have none).

Build check: `xcodebuild docbuild -scheme NeoBrutalism -destination "generic/platform=iOS Simulator"`.

## Part 2 — Swift Package Index

1. Add `.spi.yml` at repo root:
   ```yaml
   version: 1
   builder:
     configs:
       - documentation_targets: [NeoBrutalism]
   ```
2. Submit the repo to SPI (PR to `SwiftPackageIndex/PackageList` adding
   `https://github.com/rational-kunal/NeoBrutalism.git` — follow their CONTRIBUTING; it
   validates automatically). **Maintainer action** — the task ends with the PR link ready.
3. After indexing, grab the SPI badge markdown (swift versions + platforms) for T25's badge
   row.

## Part 3 — CI guard

Add a `docbuild` job (or step) to `.github/workflows/ci.yml` running the docbuild command
above, so doc breakage fails PRs. Keep it in the same runner to avoid doubling CI cost.

## Definition of done

- [ ] `docbuild` succeeds locally and in CI; zero DocC warnings about broken symbol links.
- [ ] Landing page Topics cover every public type (nothing dumped in "Other").
- [ ] `.spi.yml` merged; SPI PackageList PR opened (link in the task PR description).

## Out of scope

Hosting docs on GitHub Pages (SPI is enough); tutorials (`@Tutorial` DocC format — maybe
later); localization.
