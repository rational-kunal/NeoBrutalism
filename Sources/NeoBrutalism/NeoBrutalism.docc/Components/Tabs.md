# Tabs

A bordered tab strip with its content below.

## Overview

``NBTabView`` owns the selection; each ``NBTab`` declares its value and content:

```swift
@State private var tab = "account"

NBTabView(selection: $tab) {
    NBTab("Account", value: "account") {
        Text("Manage your account.")
    }
    NBTab("Password", value: "password") {
        Text("Change your password.")
    }
}
```

![A tab view with the Account tab selected](nb-tabs-first)

## Icons

```swift
NBTabView(selection: $tab) {
    NBTab("Home", systemImage: "house.fill", value: 0) {
        Text("Welcome home.")
    }
    NBTab("Search", systemImage: "magnifyingglass", value: 1) {
        Text("Find anything.")
    }
}
```

![A tab view whose tabs pair icons with titles](nb-tabs-icon)

## Custom tab labels

The trailing-closure form takes any view as the label, so icon-only strips are a matter of
passing an `Image`:

```swift
NBTabView(selection: $tab) {
    NBTab(value: 0) {
        GroupBox { Text("Bravery and Daring!") }
    } label: {
        Image(systemName: "flame.fill")
    }
    NBTab(value: 1) {
        GroupBox { Text("Cunning and Ambition!") }
    } label: {
        Image(systemName: "lanyardcard.fill")
    }
}
.groupBoxStyle(.neoBrutalism(elevated: false))
```

![A tab view with icon-only tabs above a flat card](nb-tabs-custom)

If `selection` holds a value no tab matches, the strip renders with nothing selected rather than
falling back to the first tab.

## Topics

### Views

- ``NBTabView``
- ``NBTab``
- ``NBTabBuilder``

## See Also

- <doc:SegmentedPicker>
