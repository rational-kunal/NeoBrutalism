# T07 — Snapshot tests for Accordion / Alert / Badge / Collapsable / root modifier

**Size:** S · **Depends on:** T29 (write these against the post-migration test stack)

## Goal

`Tests/NeoBrutalismTests/__Snapshots__/` has suites for 17 components but none for the
Accordion disclosure style, `NBAlert`, `NBBadge`, `NBCollapsable`, or the `.neoBrutalism()`
root modifier. Fill the gaps so later refactors (T06, T09–T11) have a safety net.

## Pattern to copy

Follow whatever `Tests/NeoBrutalismTests/GaugeTests.swift` looks like at the time — after
T29 that is the `assertNBSnapshot` helper (shown in T29's spec):

```swift
import NeoBrutalism
import SwiftUI
import Testing

@Suite(.snapshots(record: .missing)) @MainActor
struct AccordionTests {
    @Test func accordion_collapsed() {
        assertNBSnapshot(
            of: DisclosureGroup("Expecto Patronum") { Text("Hidden content") }
                .disclosureGroupStyle(.neoBrutalismAccordion)
        )
    }
}
```

(If T29 somehow hasn't landed, copy the existing macro-based pattern from GaugeTests
verbatim instead — but flag it, because the recorded references will need redoing.)

## New test files

1. `AccordionTests.swift` — collapsed and expanded (`DisclosureGroup(isExpanded: .constant(true))`).
2. `AlertTests.swift` — default with icon+head+desc; neutral without icon.
3. `BadgeTests.swift` — default; neutral.
4. `CollapsableTests.swift` — collapsed and expanded (`NBCollapsable(isExpanded: .constant(...))`
   wrapping the GroupBox arrangement from its `#Preview`).
5. `RootModifierTests.swift` — one "kitchen sink" test: a `VStack` containing
   `Button`, `Toggle`, `TextField("", text: .constant("text"))`, `ProgressView(value: 0.6)`,
   `DisclosureGroup`, `GroupBox`, `ControlGroup` — with **no per-view style modifiers**, just
   `.neoBrutalism()` on the stack. This is the contract test for the headline feature: it
   fails if any default style silently drops out of the root modifier.

## Definition of done

- [ ] All five suites added; snapshots recorded (run once to record, re-run to verify green).
- [ ] Eyeball every generated PNG (light + dark) before committing — a recorded-but-wrong
      snapshot is worse than none.
- [ ] Total test count increases by ~10; CI stays under its 15-minute timeout.

## Out of scope

Rewriting existing suites; testing interactions (snapshots are static).
