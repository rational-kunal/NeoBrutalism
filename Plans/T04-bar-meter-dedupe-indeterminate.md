# T04 — Shared bar meter for Progress + Gauge; indeterminate progress

**Size:** S · **Depends on:** T01 (do T01 first or fold its divider fix in here)

## Goal

`Components/Progress.swift` and `Components/Gauge/GaugeStyle.swift` contain a copy-pasted
fill/divider/track bar. Extract one internal view both styles use, and make indeterminate
`ProgressView()` (no `value:`) render sensibly — today it draws as a stuck-at-zero bar.

## Changes

1. **New internal view** `Sources/NeoBrutalism/Common/NBBarMeter.swift`:

```swift
import SwiftUI

/// The shared fill-vs-track bar used by the Progress and Gauge styles.
/// Renders the themed fill, the hard divider at the fill edge, and the track —
/// without the outer `.nbBox()`, which the caller applies.
struct NBBarMeter: View {
    @Environment(\.nbTheme) private var theme

    /// 0...1; the divider is hidden at the extremes so it never doubles the border.
    let fraction: Double

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(theme.main)
                    .frame(width: fraction * geometry.size.width, height: theme.size)

                if fraction > 0.001 && fraction < 0.99 {
                    Rectangle()
                        .fill(theme.border)
                        .frame(width: theme.borderWidth, height: geometry.size.height)
                }

                Rectangle()
                    .fill(theme.bw)
                    .frame(height: theme.size)
            }
        }
        .frame(height: theme.size)
    }
}
```

   (Note this replaces the old `Divider().background(...)` hack with a plain `Rectangle` —
   same pixels, less weirdness.)

2. **`NBProgressViewStyle`** uses it: keep the label `HStack`, replace the inner
   `GeometryReader` block with `NBBarMeter(fraction: value)` + the existing
   `.frame(maxWidth: .infinity, alignment: .leading).nbBox(elevated: false)`.

3. **`NBGaugeStyle`** — same replacement.

4. **Indeterminate progress** (`configuration.fractionCompleted == nil`): render a distinct
   "working" bar instead of an empty one — a `theme.main` segment of 30% width bouncing
   left↔right. Implementation: `@State private var indeterminatePhase = false` +
   `.onAppear { indeterminatePhase = true }` driving an
   `.animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value:)` offset;
   honor Reduce Motion (`@Environment(\.accessibilityReduceMotion)`) by rendering the segment
   statically centered instead of animating. Keep this logic inside `NBProgressViewStyle`
   (Gauge never has a nil value).

## Definition of done

- [ ] `ProgressTests` and `GaugeTests` pass **without re-recording** for the determinate
      cases (identical pixels prove the extraction is faithful).
- [ ] New snapshot test: `ProgressView()` (indeterminate) — first frame is deterministic
      (record once, verify twice to confirm stability; if animation makes it flaky, snapshot
      with reduce-motion, i.e. static centered segment).
- [ ] `#Preview` in Progress.swift gains an indeterminate example; Example app
      `ProgressExampleView` gains one too.

## Out of scope

Circular gauge/progress variants; `currentValueLabel`/bounds labels on Gauge (note them as a
future task if you feel the pull).
