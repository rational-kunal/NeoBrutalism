<!-- Publishing notes (strip before posting):
     Canonical home is the writings repo — https://github.com/rational-kunal/writings —
     publish there first so the canonical URL is yours. Then cross-post to dev.to with a
     rel="canonical" pointing back, and submit the writings URL (not this repo) to iOS Dev
     Weekly. Re-grep the code before publishing; APIs move.
     Images: the ../media/* paths render on GitHub as-is; when you cross-post to dev.to /
     writings, swap them for absolute raw URLs or re-upload. The user-attachments URLs are
     already absolute and portable. -->

# Restyling native SwiftUI controls with style protocols

*How I reskinned a whole SwiftUI app — buttons, toggles, text fields, the lot — without rewriting a single control.*

I got nerd-sniped by a question that sounds trivial and really isn't: if I want my app to look completely different — bold, blocky, thick borders, hard offset shadows, the whole neobrutalism thing — how much of SwiftUI do I actually have to rebuild to get there?

The pessimistic answer is "all of it." You wrap `Button` in your own `NBButton`, wrap `Toggle` in your own toggle, and keep going down the list until you're maintaining a shadow copy of UIKit-in-SwiftUI that drifts out of sync with the system every September. I've done a bit of that in the past. It's not fun.

The answer I landed on is much smaller. You can restyle most of a native SwiftUI app with one modifier at the root:

```swift
ContentView()
    .neoBrutalism()
```

That's the whole adoption story for the common case. Your `Button` is still a `Button`. Your `Toggle` is still a `Toggle`. They just look different now. This post is about why that works — and, the part I actually enjoyed, the handful of places where SwiftUI dug its heels in.

<p align="center">
  <img src="../media/demo.gif" width="320" alt="A plain SwiftUI app taking on the neobrutalism look after one .neoBrutalism() call, cycling through Todo, Gallery, and Themes in light and dark" />
</p>

*The whole thing in motion: plain SwiftUI, one modifier, cycling through the Example app's tabs in light and dark.*

## Why not just build custom controls

Before the how, the why, because it's the thing that kept me honest the whole way through.

The moment you replace `Button` with your own view, you're on the hook for everything the real button gave you for free: the accessibility traits, VoiceOver, focus, the press-and-drag-off-to-cancel behavior, Dynamic Type, keyboard interaction, the works. You rarely get all of that right, and you definitely don't get it right *and* keep it right across OS releases.

So the rule I set for the library was: style the native control if SwiftUI lets me, and only build a custom view when there's genuinely no native thing to style. Keep the real `Button`, and its accessibility comes along whether I think about it or not. That constraint turned out to shape the entire design.

## The actual trick: styles ride the environment

Here's the mechanism the whole thing leans on. SwiftUI's styling APIs — `buttonStyle`, `toggleStyle`, `textFieldStyle`, and their friends — don't just style the view you attach them to. They set a *default* that propagates down the view tree through the environment. Set a button style near the root and every `Button` underneath picks it up, unless something closer overrides it.

Once that clicked, the root modifier basically wrote itself. It's not clever. It just sets every style at once and injects the theme:

```swift
func body(content: Content) -> some View {
    content
        .buttonStyle(.neoBrutalism())
        .toggleStyle(.neoBrutalism)   // switch, to match native Toggle semantics
        .textFieldStyle(.neoBrutalism)
        .progressViewStyle(.neoBrutalism)
        .gaugeStyle(.neoBrutalism)
        .labelStyle(.neoBrutalism)
        .labeledContentStyle(.neoBrutalism)
        .menuStyle(.neoBrutalism)     // styles the trigger; more on that later
        .disclosureGroupStyle(.neoBrutalism)
        .controlGroupStyle(.neoBrutalism)
        .groupBoxStyle(.neoBrutalism())
        .fontDesign(theme.fontDesign)
        .environment(\.nbTheme, theme)
}
```

That's the headline feature, and it's honestly a bit anticlimactic once you see it — which is exactly why I like it. There's no runtime magic, no swizzling, no `AnyView` soup. It's a stack of the same style modifiers you'd write by hand, hoisted to one place. Every component reads the theme back out of the environment, so if you swap the theme, everything moves together.

The one opinionated call in there: the default `Toggle` style is the switch, not the checkbox, because that's what a bare `Toggle` means natively. If you want checkboxes in a subtree you ask for them — `.toggleStyle(.neoBrutalismCheckbox)` — and that closer modifier wins. Which is the propagation rule working exactly as advertised.

<p align="center">
  <img src="../media/todo-light.png" width="280" alt="The Example app's Todo screen in light mode" />
  <img src="../media/todo-dark.png" width="280" alt="The Example app's Todo screen in dark mode" />
</p>

*A real screen — the Example app's Todo tab — styled top to bottom by that single call. The text field, the add button, the progress bar, the checkboxes, the rows: all native, all reached through the environment.*

## Three tiers, because SwiftUI doesn't open every door

If the story ended at "set all the styles," this would be a short post. It doesn't, because SwiftUI only exposes a style protocol for *some* of its controls. So the library ended up with three tiers, and I think that ladder is the actually-reusable lesson here if you're building your own design system:

1. **There's a style protocol** → use it. Button, Toggle, TextField, ProgressView, Gauge, Label, LabeledContent, DisclosureGroup, GroupBox, ControlGroup, Menu (sort of — hold that thought). These all just work through the root modifier.
2. **There's no protocol, but I can reach the view with a helper modifier** → ship a helper. `List` and `Form` can't be styled through the environment, so you get `nbList()` and `nbListRow()`. Same idea for navigation chrome (`nbNavigationBar()`), the text editor (`nbTextEditor()`), sheets (`nbDrawer()`), and dialogs (`nbDialog()`).
3. **There's no native control at all, or nothing stylable** → ship a drop-in view. `Slider`, `Stepper`, segmented `Picker`, radio groups, screen-level tabs — these become `NBSlider`, `NBStepper`, `NBSegmentedPicker`, `NBRadioGroup`, `NBTabView`. Each one mirrors the native initializer as closely as I could manage, so adopting it is a rename rather than a rewrite.

The tiers are a preference order, not just a taxonomy. I only drop down a rung when the one above genuinely isn't available. Most of the churn in building the library was figuring out, control by control, which rung I was actually on — and a few of those were not obvious.

<p align="center">
  <img src="../media/gallery-light.png" width="280" alt="The Example app's component gallery in light mode" />
  <img src="../media/gallery-dark.png" width="280" alt="The Example app's component gallery in dark mode" />
</p>

*All three tiers on one screen — the Example app's gallery. Styled protocols, helper modifiers, and drop-in `NB*` views, side by side and hard to tell apart.*

## Where it got weird

Three fights stand out. They're the parts I'd actually want to read about, so they're the parts I'll show.

### 1. The text field style with no `makeBody`

Every style protocol I'd touched gives you a nice public `makeBody(configuration:)` to implement. `TextFieldStyle` doesn't. Its only requirement is a method spelled with a leading underscore — `_body(configuration:)` — which is SwiftUI's not-so-subtle way of telling you this is semi-private and you're on your own.

You implement it anyway. There's no public alternative, and it's been stable for years:

```swift
public struct NBInputStyle: TextFieldStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox(elevated: false)   // border, no shadow
    }
}
```

The nice surprise: the same style also covers `SecureField`, so the password field matches the text field with zero extra work. The not-nice surprise, and a good example of tier 1 falling through to tier 2: `TextEditor` has no style protocol at all. So right next to the style there's an `nbTextEditor()` helper that paints the same treatment by hand. Two controls that look identical on screen, reached two completely different ways, because SwiftUI decided one of them gets a protocol and the other doesn't.

<p align="center">
  <img src="https://github.com/user-attachments/assets/db0039d9-f5bd-4963-9054-e9ac18e8698b" width="330" alt="A neobrutalism-styled TextField" />
  <img src="https://github.com/user-attachments/assets/f2379fae-d46b-42b7-89b2-ceb670c63c35" width="330" alt="A neobrutalism-styled SecureField" />
</p>

*`TextField` and `SecureField`, both wearing `.textFieldStyle(.neoBrutalism)` — one `_body`, two controls.*

### 2. Rounding only the ends of a ControlGroup

A `ControlGroup` styled as a joined button bar should round only its outer corners — first section rounds its left edge, last section rounds its right, everything in the middle stays square. Easy to describe. Annoying to build, because a `ButtonStyle` has no idea where it sits in the group. Section three of five looks exactly like section one to itself.

I needed to walk the sections and hand each one its position. The tool for that is `Group(subviews:)` (iOS 18+), which lets you iterate the child views, and a custom environment key to carry the corner set down to each one — environment because it survives the subview boundary where a plain value wouldn't:

```swift
Group(subviews: configuration.content) { subviews in
    HStack(spacing: -theme.borderWidth) {   // overlap so shared edges merge into one line
        ForEach(subviews.indices, id: \.self) { index in
            subviews[index]
                .environment(\.nbSectionCorners, corners(index, of: subviews.count))
        }
    }
}
```

Two details I'm quietly pleased with. The negative spacing pulls adjacent sections together by exactly one border width, so their touching edges collapse into a single stroke instead of a clumsy double-thick line. And the corner logic is dull in the best way: first index rounds left, last rounds right, a lone section rounds everything, the rest round nothing. On iOS 17, where `Group(subviews:)` doesn't exist, it degrades to fully-rounded sections and nobody files a bug.

### 3. The menu that needed its own window

`MenuStyle` is a bit of a tease. It lets you restyle the *trigger* — the thing you tap — but the popped-open list of items is presented by the system, and you don't get to touch it. If you want a genuinely themed dropdown, you have to build and present it yourself.

Which sounds fine until you try it inside a `ScrollView` or a `List` and your beautiful dropdown gets clipped by the scroll container, or shoved behind a neighbor in the z-order. Inline overlays live inside the layout, and the layout has opinions.

The fix I landed on was to stop drawing the dropdown inside the app's view tree at all, and give it its own `UIWindow`:

```swift
func show<Content: View>(@ViewBuilder content: () -> Content) {
    // …find the active UIWindowScene…
    let window = UIWindow(windowScene: scene)
    window.rootViewController = UIHostingController(rootView: content())
    window.windowLevel = .alert + 1   // above everything, including alerts
    window.isHidden = false
}
```

Bumping `windowLevel` above `.alert` means the dropdown floats over the entire app no matter what container the trigger lives in, because it's not in that container anymore. From there it's bookkeeping: position under the trigger using its frame in the original window, flip upward when there isn't room below, clamp to the screen edges so it never runs off, and cap a very long menu at 60% of the screen height with an internal scroll. None of that is hard once the thing is free of the layout. Getting it free of the layout was the whole game.

## Knowing when to quit

The most useful discipline turned out to be knowing when *not* to style something.

Native swipe actions on a `List` row are the clearest example. SwiftUI lets you tint them and label them, and that's it — the border stroke and the square-vs-rounded corners are system-owned. There's no protocol, no underscore method, no window trick. It simply won't go fully brutalist.

I could have faked it with a gesture reimplementation, but `List` owns its own pan gesture and fights anything you bring, so that road ends in jank. So the library does the honest thing: it tints what the API exposes, writes down the ceiling in the docs, and ships a separate custom component (`nbSwipeActions`, for `LazyVStack`-based lists) for people who want the full look and can live without `List`. Tinted-but-real inside `List`; fully custom outside it. No pretending the native one is something it isn't.

That's the pattern I'd hand to anyone building this kind of thing: push each control as far up the tiers as it'll go, and when it stops, *say so* instead of shipping an off-brand hack that half-works.

## What I'd tell you if you're building your own

If you take one thing from this: styles propagate through the environment, so a design system can be one modifier for the happy path and a short, honest list of exceptions for everything else. Reach for the style protocol first. Drop to a helper modifier when there's no protocol but you can still get at the view. Only build a custom drop-in when there's truly nothing native to lean on — and when you do, mirror the native initializer so switching is a rename.

The library is [NeoBrutalism](https://github.com/rational-kunal/NeoBrutalism) — iOS 17+, MIT, snapshot-tested in light and dark. I mostly built it to answer the question at the top for myself, and I ship with it now. If you try it, I'd genuinely like to hear where the API feels off; that's the feedback I can actually use.
