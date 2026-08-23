# Collapsable

Show and hide content behind a trigger of your own design.

## Overview

Where <doc:Accordion> gives you a fixed title-and-chevron row, ``NBCollapsable`` lets you build
both halves. Mark the toggle with ``NBCollapsibleTrigger`` and the hidden part with
``NBCollapsableContent``; everything else stays visible.

```swift
@State private var isExpanded = false

NBCollapsable(isExpanded: $isExpanded) {
    GroupBox {
        HStack {
            Text("Some")
            Spacer()
            NBCollapsibleTrigger {
                Image(systemName: "chevron.up.chevron.down.square.fill")
            }
        }
    }

    NBCollapsableContent {
        GroupBox {
            Text("Content")
        }
    }
}
.groupBoxStyle(.neoBrutalism(elevated: false))
```

![A collapsed section showing only its header card](nb-collapsable-collapsed)

![The same section expanded, revealing a second card below the header](nb-collapsable-expanded)

The header sits outside `NBCollapsableContent`, so it stays on screen in both states, and the
trigger can be anywhere inside the header — it doesn't have to be the whole row.

## Topics

### Views

- ``NBCollapsable``
- ``NBCollapsableContent``
- ``NBCollapsibleTrigger``

## See Also

- <doc:Accordion>
- <doc:GroupBox>
