# Submission checklist

This is the "go press the buttons" list — the drafts are written, everything here is yours to
actually do. Each item has its real URL and whatever format the destination expects, so there's no
guessing. Spread the social posts out over a week or two (order's at the bottom), and save Show HN
for last, once the README has had a chance to harden.

First make sure the traffic has somewhere to land: the hero GIF, the README, and the hosted DocC
all need to be live (T24 / T25 / T26).

Facts worth keeping on your clipboard: repo `https://github.com/rational-kunal/NeoBrutalism` · SPI
slug `rational-kunal/NeoBrutalism` · iOS 17+ · Swift 6 · MIT · latest tag `2.0.0` (tag `3.0.0` as
part of the release — T27 — before working this list).

A one-liner you can reuse for the awesome-lists and SPI:

> NeoBrutalism — restyle a native SwiftUI app with one modifier; the controls keep their own
> accessibility and behavior.

---

## Directories & indexes

### [ ] Swift Package Index — listed and rendering DocC

- The listing itself is the `SwiftPackageIndex/PackageList` PR from **T26** (a package-add PR to
  `packages.json`, alphabetical). Confirm that PR merged.
  - PackageList repo: <https://github.com/SwiftPackageIndex/PackageList>
  - Or use the web form: <https://swiftpackageindex.com/add-a-package>
- **Verify** the page renders: <https://swiftpackageindex.com/rational-kunal/NeoBrutalism> — DocC
  builds, the platform/Swift badges are green, and the "Documentation" link resolves. `.spi.yml`
  in the repo already declares `documentation_targets: [NeoBrutalism]`.
- Requirements SPI checks (already satisfied, listed so you can confirm): public repo, root
  `Package.swift`, Swift 5+, at least one semver tag (`2.0.0` satisfies this today; `3.0.0` lands
  at release — T27).

### [ ] awesome-ios PR

- Repo: <https://github.com/vsouza/awesome-ios>
- **Read the contribution rules first:** <https://github.com/vsouza/awesome-ios/blob/master/.github/CONTRIBUTING.md>
- Format: one bullet, alphabetical within its category, ending with a period:
  ```
  * [NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism) - Restyle a native SwiftUI app with one modifier; controls keep their accessibility and behavior.
  ```
- Category: the **UI** section (no dedicated "theming/design-system" bucket exists — pick the
  closest UI subsection and match its neighbors' phrasing). The repo runs an automated linter on
  PRs; match the exact bullet punctuation or it fails.

### [ ] awesome-swiftui PR

- Lists go stale — before submitting, confirm the target still merges PRs (check the last merged
  PR date). Primary candidate, actively maintained:
  - <https://github.com/onmyway133/awesome-swiftui> — add under the **Libraries** section.
  - Alternate: <https://github.com/chinsyo/awesome-swiftui>.
- Format (match the section's existing entries; most use):
  ```
  - [NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism) - Neobrutalism styling for native SwiftUI via one root modifier.
  ```

### [ ] iOS Dev Weekly — suggest the article (not the repo)

- Suggest form: <https://suggest.iosdevweekly.com/>
- **Submit the `writings` article URL, not the GitHub repo** — iOS Dev Weekly favors teaching
  posts over release notes. So this item is blocked on the article (see
  [`article.md`](article.md)) being published to the `writings` repo first.
- Include a one-sentence "why it's interesting": it's a walkthrough of restyling native SwiftUI
  controls through style protocols, not a product pitch.

## Social posts

Copy is in [`announcement.md`](announcement.md). Space these out over ~1–2 weeks; don't fire them
all the same day.

### [ ] r/SwiftUI (+ r/iOSProgramming)

- <https://www.reddit.com/r/SwiftUI/submit> · <https://www.reddit.com/r/iOSProgramming/submit>
- Use Reddit Variant A. Post the demo GIF as the image; repo link in the body, not the title.
- Post to the two subs on **different days**. Reply to early comments within the first hour.

### [ ] X / Mastodon thread

- Use Variant B (5 posts). Attach the demo GIF to post 1, the code screenshot to post 2, the
  theming GIF (or `preset-swatches.png`) to post 3.
- Tags: `#SwiftUI` `#iOSDev`. Mastodon: post to a well-federated server (e.g. iosdev.space).

### [ ] Show HN — **do this last**

- Rules: <https://news.ycombinator.com/showhn.html> · Submit: <https://news.ycombinator.com/submit>
- Title: `Show HN: NeoBrutalism – restyle a native SwiftUI app with one modifier`
- URL: `https://github.com/rational-kunal/NeoBrutalism`
- Post the ~100-word technical comment (Variant C) immediately after submitting.
- Weekday morning US-time. Only after the README/repo have been battle-tested by the earlier rounds.

## Link-backs & community

### [ ] Offer this as the SwiftUI port to neobrutalism.dev — *low priority, see caveat*

- **Repo:** <https://github.com/ekmas/neobrutalism-components> — `ekmas` is Samuel Breznjak, the
  creator of neobrutalism.dev. (The T28 spec wrote `samuelbreznjak/neobrutalism-components`: right
  person, wrong handle — the account is `ekmas`, so the `samuelbreznjak/…` path is wrong.)
- **Caveat (checked 2026-07-19):** the repo carries a prominent "no longer maintained" banner and
  has no "ports"/community section. An issue offering a port will most likely sit unread. Treat
  this as optional and low-value — if you still want the link-back, keep it a short, zero-pressure
  introduction (not a request) and don't block anything on a reply.

### [ ] Create 3–5 `good first issue`s

- Create the label if absent, then file small, self-contained, snapshot-verifiable issues so the
  backlog attracts contributors. Each issue should link the DoD template in
  [`CONTRIBUTING.md`](../../CONTRIBUTING.md) / the Plans conventions (DocC `///` + `#Preview` +
  light/dark snapshot + Example entry + README section).
- **Note:** the T28 spec named T19/T20/T21 as first-issue candidates, but **all three already
  shipped** (Menu polish #37, Skeleton #39, Alert #38). Use these genuinely-open, well-scoped
  items instead — drawn from [`ROADMAP.md`](../../ROADMAP.md):
  1. **Avatar** component (Milestone 3 quick win) — no native counterpart; circular/rounded box,
     image + initials fallback.
  2. **Chip / Tag** component (Milestone 3 quick win) — small, close cousin of `NBBadge`.
  3. **Tooltip** component (Milestone 3 quick win) — can reuse the `NBOverlayWindow` positioning
     from `NBMenu`.
  4. **VoiceOver labels/values/traits for `NBCollapsable`** — accessibility gap; the Slider/Radio
     work (T17/T05) is the pattern to copy.
  5. **Contrast check on the default theme** (light + dark) — small audit; document/adjust any
     token pair that fails WCAG AA.

### [ ] TestFlight public link for the Example app — *optional*

- Needs a paid Apple Developer account, so mark optional. If done: build the `Example` app,
  distribute via TestFlight, enable a public link, and add it to the README.

## Already done (no action)

- [x] **README apps-list hook** — the "Built with NeoBrutalism" section already invites
      "Building something with NeoBrutalism? [Open a PR] adding it here." (Mismatch is listed).
      That apps-list is the credible social proof; no "★ if this saved you time" ask, by design.

---

### Suggested order

1. Confirm SPI listing + DocC render (foundation — do first).
2. Publish the `writings` article → dev.to cross-post (`rel=canonical`).
3. awesome-ios + awesome-swiftui PRs.
4. r/SwiftUI post (day 1), r/iOSProgramming (day 3).
5. X / Mastodon thread.
6. iOS Dev Weekly suggestion (article URL).
7. neobrutalism.dev issue + create `good first issue`s.
8. **Show HN — last**, once everything above has hardened the repo.
