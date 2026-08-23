import SwiftUI

/// A neobrutalism slider for adjusting a value within a range.
///
/// `NBSlider` is a generic slider that accepts any `BinaryFloatingPoint` value type.
/// It normalizes the value to a 0…1 fraction for rendering and supports optional
/// step-based snapping. The slider mirrors the native `Slider` API for drop-in
/// compatibility.
///
/// ```swift
/// @State var volume: Double = 30
/// NBSlider(value: $volume, in: 0...100, step: 5)
/// ```
///
/// The slider provides:
/// - Drag the thumb to adjust the value
/// - Automatic step snapping when configured
/// - Accessibility support for VoiceOver
/// - Apple's minimum 44pt touch target for the thumb
/// - Disabled state prevents interaction
public struct NBSlider<V: BinaryFloatingPoint>: View where V.Stride: BinaryFloatingPoint {
    @Environment(\.nbTheme) var theme: NBTheme
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var value: V
    private let bounds: ClosedRange<V>
    private let step: V.Stride?
    private let onEditingChanged: (Bool) -> Void

    @State private var isDragging = false

    /// Creates a neobrutalism slider.
    ///
    /// - Parameters:
    ///   - value: The value being adjusted.
    ///   - bounds: The range of valid values. Defaults to `0...1`.
    ///   - step: Optional increment to snap to.
    ///   - onEditingChanged: Called with `true` when the drag begins, `false` when it ends.
    public init(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        step: V.Stride? = nil,
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        _value = value
        self.bounds = bounds
        self.step = step
        self.onEditingChanged = onEditingChanged
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let fraction = normalize(value)
                let sliderBarWidth = geometry.size.width
                let thumbWidth = theme.size
                let thumbRadius = thumbWidth / 2
                let insetWidth = sliderBarWidth - thumbWidth
                let fillWidth = max(0, min(fraction, 1)) * insetWidth + thumbRadius
                let thumbOffsetX = max(thumbRadius, min(fraction, 1) * insetWidth + thumbRadius)
                let thumbOffsetY = theme.size / 4

                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        // Progress bar
                        Rectangle()
                            .fill(theme.main)
                            .frame(width: fillWidth - thumbRadius, height: theme.size)

                        // Background bar
                        Rectangle()
                            .fill(theme.bw)
                            .frame(height: theme.size)
                    }
                }
                .frame(width: sliderBarWidth, height: theme.smsize)
                .nbBox(elevated: false)
                .overlay {
                    Circle()
                        .fill(theme.blank)
                        .stroke(theme.border, lineWidth: theme.borderWidth)
                        .frame(width: theme.size, height: theme.size)
                        .frame(width: 44, height: 44)
                        .contentShape(Circle())
                        // `.position()` must be the last modifier: anything chained after it
                        // re-centers within the (now flexible) parent space instead of
                        // honoring this anchor, silently detaching the touch target from the
                        // computed thumb offset.
                        .position(.init(x: thumbOffsetX, y: thumbOffsetY))
                        .gesture(
                            DragGesture().onChanged { dragValue in
                                if isEnabled {
                                    if !isDragging {
                                        isDragging = true
                                        onEditingChanged(true)
                                    }
                                    let startLocation = dragValue.startLocation.x / geometry.size.width
                                    let translation = dragValue.translation.width / geometry.size.width
                                    let newFraction = max(0, min(1, startLocation + translation))
                                    updateValue(from: newFraction)
                                }
                            }.onEnded { _ in
                                if isDragging {
                                    isDragging = false
                                    onEditingChanged(false)
                                }
                            })
                }
                .frame(width: sliderBarWidth, height: theme.size)
            }
            .frame(height: theme.size)
            .padding(theme.size / 2)
        }
        .nbDisabledEffect()
        .accessibilityRepresentation {
            let valueBinding = Binding(
                get: { Double(value) },
                set: { value = V($0) }
            )
            let doubleBounds = Double(bounds.lowerBound)...Double(bounds.upperBound)
            if let step {
                Slider(value: valueBinding, in: doubleBounds, step: Double(step))
            } else {
                Slider(value: valueBinding, in: doubleBounds)
            }
        }
    }
}

// MARK: - Helpers

/// Internal (not `private`) so `Tests/NeoBrutalismTests/Unit/SliderMathTests.swift` can
/// exercise the pure fraction math via `@testable import`.
extension NBSlider {
    /// Normalize the value to a 0…1 fraction.
    func normalize(_ val: V) -> Double {
        let span = Double(bounds.upperBound - bounds.lowerBound)
        guard span > 0 else { return 0 }
        let normalized = Double(val - bounds.lowerBound) / span
        return max(0, min(1, normalized))
    }

    /// Denormalize a 0…1 fraction back to the value's range, optionally snapping to step.
    func denormalize(_ fraction: Double) -> V {
        let span = bounds.upperBound - bounds.lowerBound
        let raw = bounds.lowerBound + V(fraction) * span

        guard let step = step else { return raw }
        guard Double(step) > 0 else { return raw }

        let lowerBound = bounds.lowerBound
        let stepsFromLower = (raw - lowerBound) / V(Double(step))
        let roundedSteps = Double(stepsFromLower).rounded(.toNearestOrEven)
        let snapped = lowerBound + V(roundedSteps) * V(Double(step))

        // Rounding to the *nearest* step overshoots whenever the span isn't a whole number
        // of steps: 0...10 by 6 rounds a full-right drag (raw 10) up to 12. `normalize`
        // clamps for rendering, so the slider still looks pinned at the end while the
        // binding silently holds an out-of-range value — clamp here so it can't.
        return min(max(snapped, bounds.lowerBound), bounds.upperBound)
    }

    /// Update the value from a normalized fraction.
    func updateValue(from fraction: Double) {
        value = denormalize(fraction)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var sliderValue: Double = 50

    VStack {
        Text("Volume: \(Int(sliderValue))%")
        NBSlider(value: $sliderValue, in: 0...100, step: 5)

        Divider().padding(.vertical, 16)

        Text("Temperature (0…1)")
        NBSlider(value: .constant(0.52))

        NBSlider(value: .constant(0.2))

        NBSlider(value: .constant(1.0))

        Divider().padding(.vertical, 16)

        Text("Disabled Slider")
        NBSlider(value: .constant(0.48)).disabled(true)
    }
}
