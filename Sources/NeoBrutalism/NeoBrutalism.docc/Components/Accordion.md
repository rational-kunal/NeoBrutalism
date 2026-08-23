# Accordion

A titled row that expands to reveal content.

## Overview

`DisclosureGroup` needs nothing from you. With `.neoBrutalism()` at the root, this is already
an accordion:

```swift
DisclosureGroup("Expecto Patronum") {
    Text("Hidden content")
}
```

![A collapsed accordion row with a title and chevron](nb-accordion-collapsed)

![The same accordion expanded to show its content](nb-accordion-expanded)

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

## Styling it directly

You rarely need this. If a `DisclosureGroup` sits outside the root modifier's reach, apply
``NBAccordionDisclosureGroupStyle`` yourself:

```swift
DisclosureGroup("Expecto Patronum") {
    Text("Hidden content")
}
.disclosureGroupStyle(.neoBrutalism)
```

## Topics

### Style

- ``NBAccordionDisclosureGroupStyle``

### View

- ``NBAccordion``

## See Also

- <doc:Collapsable>
