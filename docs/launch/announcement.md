# Launch posts

Ready-to-post copy for the launch, in three flavors — Reddit, an X/Mastodon thread, and Show HN —
plus the facts and assets they lean on. Nothing here goes out on its own; posting is your call.
Grab a variant, attach the asset it asks for, drop in the repo link, hit post.

Keep the voice like [ROADMAP.md](../../ROADMAP.md): plain and honest, no hype, no rocket emojis.
You're asking for feedback, not applause.

## The facts every variant is checked against

- One modifier — `.neoBrutalism()` at the root — restyles a plain, native SwiftUI app.
- It works because SwiftUI's style protocols (`ButtonStyle`, `ToggleStyle`, `TextFieldStyle`, …)
  propagate through the environment. The root modifier just sets all of them at once.
- The controls stay native, so accessibility and behavior don't change — you're reskinning, not
  rebuilding.
- No style protocol for something? There's a helper: `nbList()`, `nbNavigationBar()`,
  `nbDialog()`, `nbTextEditor()`, `nbDrawer()`, `nbSwipeActions()`, `nbSkeleton()`.
- No native control at all? There's a drop-in `NB*` view (Slider, Stepper, segmented Picker,
  radio, tabs). Each copies the native initializer, so switching over is basically a rename.
- iOS 17+ · Swift 6 · zero runtime dependencies · snapshot-tested light + dark · MIT.
- Five preset themes besides the default (`.sunnyPeach`, `.bubblegum`, `.seafoam`, `.tangerine`,
  `.lavender`) — each changes shape, density, and font, not just the colors.
- The honest origin: it began as a "how do these style protocols actually work" experiment and
  grew into something I ship (it's in [Mismatch](https://github.com/rational-kunal/mismatch)).

## Assets these posts reference

| Asset | Status | Path / action |
|---|---|---|
| Demo GIF | ✅ ready | [`docs/media/demo.gif`](../media/demo.gif) — Todo/Gallery/Themes, light + dark |
| Preset swatches | ✅ ready | [`docs/media/preset-swatches.png`](../media/preset-swatches.png) |
| Theme gallery stills | ✅ ready | [`docs/media/themes-light.png`](../media/themes-light.png) / [`themes-dark.png`](../media/themes-dark.png) |
| **Theming GIF** (thread, post 3) | ⚠️ need to capture | record the Themes tab live-switching with [`Example/capture.sh`](../../Example/capture.sh); in a pinch, `preset-swatches.png` works |
| **Code screenshot** (thread, post 2) | ⚠️ need to capture | run the snippet below through carbon.now.sh or CodeSnap |
| **Before/after GIF** (optional) | ⚠️ nice to have | plain SwiftUI → `.neoBrutalism()` side by side; the demo GIF stands in fine if you skip it |

Repo link to paste everywhere: `https://github.com/rational-kunal/NeoBrutalism`

Snippet for the thread's code screenshot (post 2):

```swift
// Plain SwiftUI…
VStack {
    Toggle("Shield Charm", isOn: $shieldOn)
    Button("Cast Spell") {}
    TextField("Add a task…", text: $text)
}
.neoBrutalism()   // …one modifier restyles the lot
```

---

## Variant A — Reddit (r/SwiftUI, r/iOSProgramming)

**Title:** `A SwiftUI neobrutalism library you apply with one modifier — would love feedback`

**Body** (~200 words; post the demo GIF as the image, put the link in the body):

> I've been building this on and off for a while and finally want some outside eyes on it.
>
> The idea: you write normal SwiftUI — `Button`, `Toggle`, `TextField`, `List`, `GroupBox` — and
> drop `.neoBrutalism()` at the root of your view tree. Everything underneath picks up a bold
> neobrutalist look through the standard style protocols, which propagate down the environment.
> The controls stay native, so you don't lose accessibility or behavior — it's a reskin, not a
> rewrite.
>
> Where SwiftUI won't let you style something (List, nav bars, dialogs) there are small opt-in
> helpers. Where there's no native control at all (Slider, Stepper, segmented Picker, radio) there
> are drop-in `NB*` views that copy the native initializer, so swapping them in is close to a
> rename.
>
> iOS 17+, Swift 6, MIT, snapshot-tested in light and dark. Five preset themes if the default
> isn't your thing.
>
> It honestly started as a "how do SwiftUI style protocols actually work" experiment and turned
> into something I ship. I'm after feedback more than stars — especially if the API feels
> un-idiomatic anywhere, or there's a control you'd want that's missing.
>
> [repo link]

Reddit notes: reply to early comments fast, the first hour sets the reach. Don't hit both subs the
same day.

---

## Variant B — X / Mastodon thread (5 posts)

**1/** (attach `demo.gif`)

> You write plain SwiftUI. You add one modifier at the root. The whole app goes neobrutalist — and
> the controls are still the real native ones, so accessibility and behavior stick around.
>
> Been building this a while, finally sharing it 👇

**2/** (attach the code screenshot)

> Why it works: SwiftUI's style protocols — ButtonStyle, ToggleStyle, TextFieldStyle… — propagate
> through the environment. `.neoBrutalism()` just sets all of them at the root, so every control
> underneath restyles itself. No per-view styling.

**3/** (attach the theming GIF, or `preset-swatches.png`)

> Theming is one value in the environment. `.neoBrutalism(theme: .bubblegum)` and the corners,
> borders, shadows, padding and font all change together.
>
> Five presets ship. A custom one is just a struct.

**4/** (no media)

> SwiftUI doesn't give you a style hook for everything, and I didn't pretend otherwise:
>
> • List/Form, nav bars, dialogs → small opt-in helpers
> • Slider/Stepper/segmented Picker/radio → drop-in NB* views that match the native init

**5/** (no media)

> iOS 17+, Swift 6, MIT, snapshot-tested light + dark. Started as a "how do these protocols
> actually work" experiment, became something I ship.
>
> If you try it, tell me where the API feels wrong:
> [repo link]
>
> #SwiftUI #iOSDev

Mastodon note: same copy is fine. Post to a server that federates well (iosdev.space works), and
skip the thread-bait tone — it doesn't land there.

---

## Variant C — Show HN

**Title:** `Show HN: NeoBrutalism – restyle a native SwiftUI app with one modifier`

**URL:** `https://github.com/rational-kunal/NeoBrutalism`

**First comment** (~100 words — post it the moment you submit):

> Author here. The part I found interesting building this: SwiftUI's style protocols —
> ButtonStyle, ToggleStyle, TextFieldStyle and so on — propagate down the view tree through the
> environment. So `.neoBrutalism()` just sets the default for all of them at the root, and every
> native control underneath restyles itself. Because the real Button/Toggle/TextField stay put,
> accessibility and behavior come for free.
>
> Custom views only exist where SwiftUI gives you nothing to style — List/Form, nav chrome, and
> dialogs get helpers; controls with no protocol (Slider, Stepper) ship as drop-in NB\* views that
> copy the native initializer. iOS 17+, MIT. Happy to answer questions.

HN notes: skim the [Show HN rules](https://news.ycombinator.com/showhn.html) first, post on a
weekday morning US-time, and drop the comment right away. Do this one **last** — HN is unforgiving
of rough edges, so let the README get battle-tested on Reddit and X first.
