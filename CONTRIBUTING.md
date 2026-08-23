# Contributing to NeoBrutalism

Thanks for considering a contribution. This file covers dev setup, testing, and the PR
checklist. For *what* to build next, see [ROADMAP.md](ROADMAP.md) and the implementation-ready
task specs in [`Plans/`](Plans/README.md) — issues labeled
[`good first issue`](https://github.com/rational-kunal/NeoBrutalism/labels/good%20first%20issue)
are a good place to start if you're new to the codebase.

## Dev setup

1. Install Xcode. Snapshot tests are pinned to a specific Xcode/iOS/simulator combination
   (currently Xcode 26.2 — see [`Scripts/snapshot-env.sh`](Scripts/snapshot-env.sh) for the
   exact pin); other steps work with any recent Xcode.
2. Open [`Package.swift`](Package.swift) directly in Xcode — the library is a plain Swift
   Package (Swift tools 6.0, iOS 17+), there's no `.xcodeproj` at the top level.
3. The [`Example/`](Example) app is a separate Xcode project (`Example/Example.xcodeproj`)
   that depends on the package via a local path reference — open it to try components in a
   real app.

## Building a new component

Follow the same pattern as `Badge.swift` or `Alert.swift`:

1. Prefer a native style protocol; only make a `public struct NB<Name>` view if none exists.
2. Read the theme with `@Environment(\.nbTheme)`; add a `.default` / `.neutral` type
   if it needs a color variant.
3. Style with theme tokens and finish with `.nbBox()`.
4. Add a `#Preview` and a light + dark snapshot test in `Tests/NeoBrutalismTests/`.
5. Add a `Components/<Name>.md` page to the DocC catalog, and an Example app entry.

See the [Conventions section of `Plans/README.md`](Plans/README.md#conventions-the-contract-for-every-task)
for the full house style (native-first, theme tokens only, box + press language,
accessibility, staying brutalist).

## Running and recording snapshot tests

```bash
# Build (fast sanity check — the package is iOS-only, so plain `swift build` won't work):
xcodebuild -scheme NeoBrutalism -destination "generic/platform=iOS Simulator" build

# Snapshot tests — MUST run on the pinned reference environment (see Plans/TESTING.md):
Scripts/test.sh          # pins iPhone 16 · iOS 26.2, boots/creates the sim if needed
Scripts/record.sh        # local preview of visual changes — committed PNGs come from CI (below)
```

Reference images live in `Tests/NeoBrutalismTests/__Snapshots__/<Suite>/<test>.{light|dark}.png`.

**Every committed reference PNG is recorded by CI, not locally.** Local Xcode/simulator
builds can drift slightly from the pinned CI environment, so a PNG recorded by a local
`Scripts/record.sh` run will often fail on CI (and vice versa) — don't commit them. The one
canonical recorder is the
[Re-record snapshots](.github/workflows/record-snapshots.yml) workflow: push your branch/PR,
then Actions tab → "Re-record snapshots" → Run workflow against that branch. It records on
the pinned environment and pushes the updated PNGs straight to the branch, so they show up
in the PR diff for review. Local record/test remains useful to iterate fast and eyeball what
changed — treat it as a preview, never as the verdict or the source of committed references.

- New snapshot test → commit the test (no PNGs), push, run the re-record workflow, then let
  the PR's normal test run confirm it's stable.
- Intentional visual change → same flow; eyeball every changed PNG (and the Example app) in
  the PR diff before merging.
- Never blanket-delete `__Snapshots__`.

## Writing documentation

The published docs are the DocC catalog in
`Sources/NeoBrutalism/NeoBrutalism.docc/`, deployed to
[GitHub Pages](https://rational-kunal.github.io/NeoBrutalism/documentation/neobrutalism)
on every push to `main`.

`Components/` holds one page per component — what it looks like, the code to paste, and its
variants, states, and disabled appearance. Each page illustrates itself with the **snapshot
references**, so the docs and the tests can never disagree about what a component renders.

```bash
Scripts/sync-doc-images.sh   # derive the DocC imagery from __Snapshots__ (required first)
xcodebuild docbuild -scheme NeoBrutalism -destination "generic/platform=iOS Simulator"
```

`sync-doc-images.sh` downsamples a curated subset of `__Snapshots__` into
`Resources/Generated/` under DocC's light/dark naming (`name@2x.png` / `name~dark@2x.png`).
That folder is generated, not committed — CI regenerates it before every docs build. Skip the
script and the images simply won't resolve.

To illustrate something new, add a `Suite/snapshot_name  doc-image-name` row to the manifest
inside the script and reference it as `![alt](doc-image-name)`. The snapshot must already
exist; the script only copies, it never renders. If a row points at a snapshot that has been
renamed or deleted, the script fails loudly rather than quietly shipping a broken page.

Two DocC conventions worth knowing:

- Curate each symbol in exactly **one** `## Topics` group — its component page. Curating the
  same symbol twice makes it appear twice in the sidebar.
- Cross-links between pages go in `## See Also`, never in `## Topics`. A `<doc:>` link inside
  `Topics` is *curation*, and mutual links there form a hierarchy cycle that DocC warns about.

## PR checklist

For any change to a public API:

- [ ] DocC comment (`///`) with a code example.
- [ ] `#Preview(traits: .modifier(NBPreviewHelper()))`.
- [ ] Light + dark snapshot test(s) (generated by the suite, recorded via CI — see above).
- [ ] Example app entry (`Example/Sources/ContentView.swift`).
- [ ] DocC component page (`Sources/NeoBrutalism/NeoBrutalism.docc/Components/`), with
      imagery wired up via `Scripts/sync-doc-images.sh`.
- [ ] Renames are additive: add the new name, mark the old one
      `@available(*, deprecated, renamed:)` — don't remove public API before a major version.

Keep PRs scoped to one concern; that's what makes them reviewable and revertable.
