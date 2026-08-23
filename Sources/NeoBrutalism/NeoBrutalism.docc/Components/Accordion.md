# Accordion

A titled row that expands to reveal content.

## Overview

`DisclosureGroup` is styled by the root modifier through
``NBAccordionDisclosureGroupStyle``:

```swift
DisclosureGroup("Expecto Patronum") {
    Text("Hidden content")
}
```

![A collapsed accordion row with a title and chevron](nb-accordion-collapsed)

![The same accordion expanded to show its content](nb-accordion-expanded)

Or explicitly — `.neoBrutalism` and `.neoBrutalismAccordion` are the same style under two names:

```swift
DisclosureGroup("Expecto Patronum") {
    Text("Hidden content")
}
.disclosureGroupStyle(.neoBrutalism)
```

## Controlling expansion

Bind `isExpanded` when the state needs to live outside the view — for example to keep only one
section open at a time:

```swift
DisclosureGroup("Expecto Patronum", isExpanded: $isExpanded) {
    Text("Hidden content")
}
.disclosureGroupStyle(.neoBrutalism)
```

## When you need a different shape

`DisclosureGroup` always draws a title row with a chevron. When the trigger has to be something
else entirely — a card, an image, a custom header — use <doc:Collapsable> instead.

## Topics

### Style

- ``NBAccordionDisclosureGroupStyle``

### View

- ``NBAccordion``

## See Also

- <doc:Collapsable>
