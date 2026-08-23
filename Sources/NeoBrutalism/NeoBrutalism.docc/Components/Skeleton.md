# Skeleton

Placeholder shapes that pulse while real content loads.

## Overview

There are two ways to show a loading state, and which you want depends on whether you already
have a laid-out view to stand in for.

| Approach | Use when |
|---|---|
| Compose ``NBRoundSkeleton`` / ``NBTextSkeleton`` | You're building a placeholder by hand and want it to mimic the shape of the content. |
| ``SwiftUICore/View/nbSkeleton(active:)`` on a real view | You already have the view and just want it covered while it loads. |

## Composing placeholders

``NBRoundSkeleton`` is a circle for avatars and icons; ``NBTextSkeleton`` is a bar sized like a
line of text. Each pulses on its own.

```swift
NBRoundSkeleton()
NBTextSkeleton()
```

![A round skeleton placeholder](nb-skeleton-round)

![A text-line skeleton placeholder](nb-skeleton-text)

Both fill the space they're given, so `frame` controls their size:

```swift
HStack(spacing: 12) {
    NBRoundSkeleton()
        .frame(width: 48, height: 48)

    VStack(alignment: .leading, spacing: 4) {
        NBTextSkeleton()
            .frame(height: 12)
        NBTextSkeleton()
            .frame(maxWidth: 120)
            .frame(height: 8)
    }
}
```

That builds a placeholder shaped like the row it stands in for — an avatar beside two lines of
text.

## Replacing a view while it loads

``SwiftUICore/View/nbSkeleton(active:)`` works the other way round: give it your **real** view
and, while `active` is `true`, it hides that view and draws a single pulsing box occupying
exactly the same space.

```swift
ProfileRow(user: user)
    .nbSkeleton(active: isLoading)
```

![A single pulsing placeholder box standing in for a row of content](nb-skeleton-modifier)

One box, whatever the view contained — it takes the size, not the shape. Flip `active` to
`false` and the real view renders normally.

> Tip: Because it borrows the real view's size, you don't have to keep a placeholder in sync
> with a layout as that layout changes. Reach for the hand-composed approach only when you want
> the placeholder to echo the *internal* shape of the content rather than just its footprint.

## Accessibility

The skeleton primitives are hidden from assistive technology, and a view covered by
`nbSkeleton(active:)` is announced as "Loading" and marked as updating frequently. The pulse
respects Reduce Motion — with it on, the placeholder renders statically instead of animating.

## Topics

### Views

- ``NBRoundSkeleton``
- ``NBTextSkeleton``

### Modifier

- ``SwiftUICore/View/nbSkeleton(active:)``

## See Also

- <doc:Progress>
