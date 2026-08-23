# Build a form

Text fields, toggles, a picker, and a submit button.

## Overview

Forms are the case where NeoBrutalism asks for almost nothing: every control here is plain
SwiftUI, styled by the one call at the bottom.

## The whole thing

```swift
struct SignUpView: View {
    @State private var name = ""
    @State private var password = ""
    @State private var plan = "Free"
    @State private var acceptsEmail = false
    @State private var remember = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Name", text: $name)
            SecureField("Password", text: $password)

            NBSegmentedPicker(selection: $plan) {
                Text("Free").nbSegment("Free")
                Text("Pro").nbSegment("Pro")
            }

            Toggle("Email me updates", isOn: $acceptsEmail)

            Toggle("Remember me", isOn: $remember)
                .toggleStyle(.neoBrutalismCheckbox)

            Button("Create account") {}
        }
        .padding()
        .neoBrutalism(applyBackground: true)
    }
}
```

## What needed a modifier, and why

Only two lines in that form aren't plain SwiftUI:

- **``NBSegmentedPicker``** — SwiftUI's segmented `Picker` can't be restyled, so this is a
  drop-in replacement that mirrors its shape.
- **`.toggleStyle(.neoBrutalismCheckbox)`** — a `Toggle` is a switch by default, matching
  native behavior. The checkbox is opt-in, per toggle.

Everything else — the fields, the switch, the button — is styled by `.neoBrutalism()` at the
bottom.

![A text field containing user-entered text](nb-input-filled)

![A segmented picker with the first of three segments selected](nb-segmented-first)

## Grouping it into a card

Wrap sections in a `GroupBox` to get the bordered card look without a `List`:

```swift
GroupBox("Account") {
    VStack(spacing: 12) {
        LabeledContent("Username", value: "johndoe")
        LabeledContent("Plan", value: "Pro")
    }
}
```

![A card containing three labelled value rows](nb-labeledcontent-groupbox)

## Confirming before you submit

For a destructive action, ``SwiftUICore/View/nbDialog(_:isPresented:actions:message:)`` gives a
themed confirmation instead of the system alert:

```swift
.nbDialog("Delete account?", isPresented: $confirming) {
    Button("Delete", role: .destructive) { delete() }
    Button("Keep") {}
} message: {
    Text("This cannot be undone.")
}
```

![A confirmation dialog card asking Delete spell?, with Delete and Keep buttons](nb-dialog-card)

## See Also

- <doc:TextInput>
- <doc:SegmentedPicker>
- <doc:Checkbox>
- <doc:Dialog>
