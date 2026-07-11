# T21 — NBAlert string-based initializers

**Size:** XS · **Depends on:** nothing

## Goal

`NBAlert` (`Sources/NeoBrutalism/Components/Alert.swift`) requires three view builders in an
unusual order (`desc:` → `icon:` → `head:`) for the common "title + message + symbol" case.
Add the obvious conveniences without touching the existing generic initializer.

## Changes

Add to `Alert.swift`:

```swift
public extension NBAlert where Icon == Image, Head == Text, Desc == Text {
    /// Creates an alert from a title, message, and SF Symbol.
    ///
    /// ```swift
    /// NBAlert("Warning", message: "The Chamber has been opened.",
    ///         systemImage: "exclamationmark.triangle")
    /// ```
    init(_ title: LocalizedStringKey, message: LocalizedStringKey,
         systemImage: String, type: AlertType = .default) { … }
}

public extension NBAlert where Icon == EmptyView, Head == Text, Desc == Text {
    /// Creates an alert from a title and message, without an icon.
    init(_ title: LocalizedStringKey, message: LocalizedStringKey,
         type: AlertType = .default) { … }
}
```

Implementation: delegate to the designated init
(`self.init(type: type, desc: { Text(message) }, icon: …, head: { Text(title) })`).
`LocalizedStringKey` (not `String`) so string literals localize, matching SwiftUI convention.

Update the `#Preview` and Example app's `AlertExampleView` to use the short form for the
simple cases (keep one builder-form example to show it exists).

## Definition of done

- [ ] `AlertTests` (added in T07) gains one test using the string init; existing snapshots
      pass without re-recording.
- [ ] README Alert section leads with the one-liner.

## Out of scope

Semantic variants (success/warning/danger colors) — the theme has one accent by design; a
semantic-palette story is a bigger theming decision. Dismissible/auto-hiding alerts (toast
territory — future component).
