# T28 — Launch kit: posts, submissions, link-backs

**Size:** S (writing) + maintainer actions · **Depends on:** T24/T25/T26 (must have the hero
GIF, README, and docs live before pointing traffic at them)

## Goal

"People visit + try + actually use it" needs distribution, not just polish. This task
produces the *materials*; posting is the maintainer's call. Everything lands in
`docs/launch/` as markdown drafts.

## Deliverables

1. **`docs/launch/announcement.md`** — the canonical short post, three variants:
   - *r/SwiftUI / r/iOSProgramming*: 150–250 words, leads with the before/after GIF and the
     one-modifier claim, honest "learning project that grew" origin, asks for feedback not
     stars. Reddit hates marketing-speak — write like the ROADMAP is written.
   - *X/Mastodon thread* (4–5 posts): 1) GIF + one-liner, 2) the style-protocol trick with a
     code screenshot, 3) theming GIF, 4) what's NOT stylable and the helpers, 5) link + ask.
   - *Show HN*: title `Show HN: NeoBrutalism – restyle a native SwiftUI app with one modifier`
     + 100-word comment focusing on the technical bit (style protocols propagate via
     environment; custom views only where SwiftUI has no hook).
2. **`docs/launch/article.md`** — outline (not full draft) for a build-log article,
   *"Restyling native SwiftUI controls with style protocols"*: the protocol inventory table
   from `Plans/README.md`, the `_body` TextFieldStyle hack, the ControlGroup
   `Group(subviews:)` corner trick, the NBMenu overlay-window story. **Canonical home: the
   author's `writings` repo (https://github.com/rational-kunal/writings)** — publish the full
   post there so the canonical URL is owned, cross-post to dev.to with a `rel=canonical` link
   back, and submit *that* writings URL (not the repo) to iOS Dev Weekly (they favor teaching
   posts over release notes). Keep the `docs/launch/article.md` outline here as the working
   draft; `writings` being a work-in-progress must not block the rest of the launch kit.
3. **`docs/launch/checklist.md`** — submission checklist with URLs:
   - [ ] Swift Package Index listed (T26) — verify page renders docs
   - [ ] awesome-swiftui + awesome-ios PRs (follow each list's contribution format)
   - [ ] iOS Dev Weekly submission (via their suggest form, link the article not the repo)
   - [ ] r/SwiftUI post · X thread · Show HN (space these out; HN last, README battle-tested)
   - [ ] Issue on neobrutalism.dev's repo (`ekmas/neobrutalism-components` — `ekmas` is the
         creator of neobrutalism.dev) offering this as the SwiftUI port for their "ports"
         section — polite, zero-pressure
   - [ ] 3–5 `good first issue`s created from genuinely-open work (T19/T20/T21 have shipped, so
         they are no longer candidates — draw from the open ROADMAP items instead: Avatar,
         Chip/Tag, Tooltip, `NBCollapsable` VoiceOver, default-theme contrast check — all small,
         specced, snapshot-verified)
   - [ ] TestFlight public link for the Example app (needs paid dev account — mark optional)
4. **README hook**: add "★ if this saved you styling time" nowhere. Instead: "Using it in an
   app? Open a PR to add yours" — the apps-list is the credible social proof.

## Definition of done

- [ ] All drafts written in the repo, factually consistent with the shipped API (every code
      claim compiles).
- [ ] Checklist items each have the exact submission URL and any format requirements pasted
      in, so executing is mechanical.
- [ ] Nothing published by the agent — publishing is explicitly the maintainer's move.

## Out of scope

Paid promotion; a website; App Store release of the Example app.
