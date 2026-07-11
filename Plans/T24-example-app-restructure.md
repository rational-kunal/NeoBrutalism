# T24 — Example app: real-app-first + capture kit

**Size:** M · **Depends on:** T11 (root modifier v2), T23 (tab structure exists)

## Goal

Adoption argument: a stranger should open the Example app (or its GIF) and think "that's a
real app, and it took one modifier." Today the Example leads with a component wall and the
Todo demo is commented out. Restructure + make screenshot/GIF capture repeatable.

## Part 1 — restructure

In `Example/Sources/`:

1. **Todo becomes the flagship** (first tab). Rework `TodoView.swift` so it is a plausible
   mini-app that uses **zero per-view style modifiers** — everything from `.neoBrutalism()`
   at its root — except where a deliberate variant is the point (e.g. one
   `.buttonStyle(.neoBrutalism(type: .neutral))`). It should exercise: `TextField` +
   add-Button, a List of rows via `nbListRow()` (T12) with swipe-to-delete, checkbox
   toggles, a progress header ("3 of 7 done" `ProgressView`), an `NBMenu` for sort options,
   and `nbDialog` (T16) for "delete all" confirmation. Every fixme in it (per-row `@State
   isChecked` instead of binding into the model — fix that: `ForEach($todos) { $todo in … }`).
2. **Component gallery stays** as the second tab, but grouped with section headers
   ("Controls", "Containers", "Feedback", "Loading") instead of one flat wall.
3. **Themes** tab from T23 stays third.
4. Delete the commented-out body variant in `ContentView.swift`.

## Part 2 — capture kit

New `Example/capture.sh` (documented at top of the script):

```bash
#!/bin/zsh
# Boots a simulator, builds the Example app, and records screenshots + a demo video
# for README material. Usage: ./capture.sh [simulator-name]
```

- Boot (or reuse) an iPhone 16 simulator, `xcodebuild -project Example… build` + install +
  launch, then `xcrun simctl io booted screenshot docs/media/<screen>-<light|dark>.png` for
  each tab (drive tab switching manually — script pauses with a "press enter when on tab X"
  prompt; keep it dumb and reliable), and `xcrun simctl io booted recordVideo docs/media/demo.mov`
  wrapped around a manual walkthrough.
- Output into `docs/media/` (gitignore the `.mov`, keep optimized GIFs/PNGs — add a note that
  GIF conversion is `ffmpeg -i demo.mov -vf "fps=12,scale=480:-1" demo.gif` if ffmpeg exists).

## Definition of done

- [ ] Example app: three tabs, Todo first, builds and runs; Todo screen contains **at most
      two** explicit style modifiers (count them in the PR description).
- [ ] `./capture.sh` produces PNGs for all three tabs in light + dark on a clean checkout
      (document any manual steps it needs).
- [ ] `docs/media/` committed with the first real capture set.

## Out of scope

README edits that *use* the media (T25); TestFlight (T28); UI tests.
