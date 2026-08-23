# Text input

Bordered fields for single-line, secure, and multi-line text.

## Overview

`TextField` and `SecureField` are styled by
``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` through ``NBInputStyle``:

```swift
TextField("Add a task…", text: $text)
```

![A neobrutalism text field containing text](nb-input-filled)

To style a field on its own, apply the style directly:

```swift
TextField("Add a task…", text: $text)
    .textFieldStyle(.neoBrutalism)
```

## Placeholder and content

An empty field shows its placeholder in the muted text color; a filled field uses the theme's
`text` token.

![An empty text field showing its placeholder](nb-input-empty)

![A text field containing user-entered text](nb-input-filled)

## Secure entry

`SecureField` takes the same style, so password fields match the rest of the form:

```swift
SecureField("Password", text: $password)
    .textFieldStyle(.neoBrutalism)
```

![A secure field with masked content](nb-securefield)

## Multi-line text

`TextEditor` has no style protocol in SwiftUI, so it gets a helper modifier instead —
``SwiftUICore/View/nbTextEditor()``. The root modifier cannot reach it for you.

```swift
TextEditor(text: $notes)
    .nbTextEditor()
    .frame(height: 100)
```

![A bordered multi-line text editor](nb-texteditor)

## Disabled

```swift
TextField("Add a task…", text: $text)
    .textFieldStyle(.neoBrutalism)
    .disabled(true)
```

![A disabled text field](nb-input-disabled)

![A disabled text editor](nb-texteditor-disabled)

## Topics

### Style

- ``NBInputStyle``

### Helper

- ``SwiftUICore/View/nbTextEditor()``
