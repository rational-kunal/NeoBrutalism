# T25 — README overhaul: hero, 10-second pitch

**Size:** S · **Depends on:** T11 (the pitch is the root modifier), T24 (media exists),
T22 (presets to show)

## Goal

A GitHub visitor decides in ~10 seconds. The current README opens with a banner and a
paragraph of history; the one-modifier magic is buried at line ~180. Restructure so the value
is unmissable, keeping all existing per-component sections (they're good).

## Target structure

1. **Banner** (keep) + badges. Add: platform badge (iOS 17+), Swift 6, license, and — after
   T26 — the two Swift Package Index badges (swift-versions / platforms shield URLs).
2. **The pitch** — immediately, before any prose:
   ```swift
   // Plain SwiftUI…
   var body: some View {
       Form { Toggle("Shield charm", isOn: $on); Button("Cast") {} … }
   }

   // …one modifier later:
   .neoBrutalism()
   ```
   directly followed by the hero GIF from T24 (`docs/media/demo.gif`) — before/after is the
   whole story. One sentence under it: *"Native SwiftUI controls, restyled through standard
   style protocols — keep your code, your accessibility, your behavior."*
3. **Quick start** — install (keep current SPM steps) + the two-line usage
   (`.neoBrutalism(applyBackground: true)`), + "want a different look?" one-liner with
   `theme: .bubblegum` and a 5-swatch preset strip image.
4. **What gets styled** — compact table: the native controls covered by the root modifier /
   the helpers (`nbList`, `nbNavigationBar`, `nbTextEditor`, `nbDrawer`, `nbDialog`) / the
   drop-in `NB*` views for unstylable controls. Link each row to its README section below.
5. **Components** — existing per-component sections stay, updated for any API changes
   (T10 names, T17 slider, T21 alert). Refresh stale screenshots opportunistically, not
   exhaustively.
6. **Theming** — tokens paragraph, `updateBy` example, preset gallery image, link to DocC
   theming article (T26).
7. **Architecture / Contributing / Credits** — keep; move the architecture tree lower (it
   serves contributors, not evaluators). Keep the neobrutalism.dev credit prominent.

## Writing rules

- Every code block must compile against the current API — extract them into a scratch file
  and build once before committing (`Example` target is a convenient host).
- No claims ahead of reality: only list helpers/tasks that have shipped. This task should be
  re-run (cheap) after later phases land.
- Screenshots: light+dark pairs as today; prefer the capture-kit output for consistency.

## Definition of done

- [ ] Above-the-fold (first screen of GitHub rendering) shows: banner, pitch code, hero GIF.
- [ ] All snippets build; all links resolve; stale `neoBrutalismChecklist` references gone.
- [ ] "Apps built with NeoBrutalism" section kept (Mismatch) with a call-to-action to PR
      your app.

## Out of scope

DocC content (T26); non-English translations; CHANGELOG (T27).
