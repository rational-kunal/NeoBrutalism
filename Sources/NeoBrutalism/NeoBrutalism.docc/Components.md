# Components

Every component, what it looks like, and the code to paste.

## Overview

Components come in three shapes, and which one you get depends on what SwiftUI allows:

| Shape | How you use it | Example |
|---|---|---|
| **Styled native control** | Nothing — ``SwiftUICore/View/neoBrutalism(theme:applyBackground:)`` at the root covers it | <doc:Button>, <doc:Switch>, <doc:Progress> |
| **Opt-in helper** | A modifier on the view, because SwiftUI exposes no style protocol | <doc:ListsAndForms>, <doc:Navigation> |
| **Drop-in view** | An `NB*` view mirroring the native initializer, where no native control exists | <doc:Slider>, <doc:Stepper>, <doc:Tabs> |

If a page shows a snippet with no style modifier on it, that component is already covered by the
root modifier — the explicit form is there for when you need one styled control inside a subtree
the root modifier doesn't own.

Every image on these pages is a real snapshot reference, rendered by the test suite on a pinned
simulator. What you see is what the component draws.

## Topics

### Controls

- <doc:Button>
- <doc:Checkbox>
- <doc:Switch>
- <doc:Radio>
- <doc:TextInput>
- <doc:Slider>
- <doc:Stepper>
- <doc:SegmentedPicker>
- <doc:Menu>

### Indicators

- <doc:Progress>
- <doc:Gauge>
- <doc:Badge>
- <doc:Skeleton>

### Containers

- <doc:GroupBox>
- <doc:ControlGroup>
- <doc:Label>
- <doc:LabeledContent>
- <doc:Accordion>
- <doc:Collapsable>
- <doc:Tabs>

### Screen structure

- <doc:ListsAndForms>
- <doc:Navigation>
- <doc:SwipeActions>

### Overlays

- <doc:Alert>
- <doc:Dialog>
