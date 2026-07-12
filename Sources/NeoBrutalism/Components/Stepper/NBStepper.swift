import SwiftUI

/// A neo-brutalism styled stepper control that allows incrementing and decrementing an integer value.
///
/// `NBStepper` mirrors the native `Stepper` API while applying the neo-brutalism visual style
/// with bordered buttons, shadow effects, and spring press animations.
///
/// ```swift
/// @State var quantity = 1
/// NBStepper("Quantity", value: $quantity, in: 0...10)
/// ```
public struct NBStepper<Label: View>: View {
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding private var value: Int
    private let range: ClosedRange<Int>
    private let step: Int
    private let label: Label
    private let accessibilityLabelText: String?

    @State private var isMinusPressed = false
    @State private var isPlusPressed = false
    @State private var repeatTimer: Timer?

    /// Creates a stepper with a custom label.
    /// - Parameters:
    ///   - value: A binding to an integer value.
    ///   - range: The closed range of valid values.
    ///   - step: The value to increment or decrement by (default: 1).
    ///   - label: A view that describes the stepper's purpose.
    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1,
        accessibilityLabelText: String? = nil,
        @ViewBuilder label: () -> Label
    ) {
        _value = value
        self.range = range
        self.step = step
        self.label = label()
        self.accessibilityLabelText = accessibilityLabelText
    }

    public var body: some View {
        HStack(spacing: theme.spacing) {
            label
                .foregroundStyle(theme.text)

            Spacer()

            HStack(spacing: 0) {
                // Minus button
                Button {
                    decrement()
                } label: {
                    Image(systemName: "minus")
                        .font(.body.weight(.bold))
                        .foregroundStyle(theme.text)
                        .frame(width: theme.xlsize + theme.padding, height: theme.xlsize + theme.padding)
                }
                .disabled(value <= range.lowerBound)
                .opacity(value <= range.lowerBound ? 0.4 : 1.0)
                .background(theme.bw)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isMinusPressed = true
                            if repeatTimer == nil {
                                scheduleRepeatTimer(isIncrement: false)
                            }
                        }
                        .onEnded { _ in
                            isMinusPressed = false
                            invalidateRepeatTimer()
                        }
                )

                // Divider
                Rectangle()
                    .fill(theme.border)
                    .frame(width: theme.borderWidth)

                // Value display
                Text("\(value)")
                    .font(.body.weight(.medium))
                    .foregroundStyle(theme.text)
                    .frame(minWidth: theme.xlsize + theme.padding, alignment: .center)
                    .padding(.horizontal, theme.smpadding)
                    .background(theme.bw)

                // Divider
                Rectangle()
                    .fill(theme.border)
                    .frame(width: theme.borderWidth)

                // Plus button
                Button {
                    increment()
                } label: {
                    Image(systemName: "plus")
                        .font(.body.weight(.bold))
                        .foregroundStyle(theme.text)
                        .frame(width: theme.xlsize + theme.padding, height: theme.xlsize + theme.padding)
                }
                .disabled(value >= range.upperBound)
                .opacity(value >= range.upperBound ? 0.4 : 1.0)
                .background(theme.bw)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPlusPressed = true
                            if repeatTimer == nil {
                                scheduleRepeatTimer(isIncrement: true)
                            }
                        }
                        .onEnded { _ in
                            isPlusPressed = false
                            invalidateRepeatTimer()
                        }
                )
            }
            .fixedSize(horizontal: true, vertical: true)
            .nbPressEffect(isPressed: isMinusPressed || isPlusPressed)
        }
        .nbDisabledEffect()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabelText ?? "Stepper")
        .accessibilityValue("\(value)")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                increment()
            case .decrement:
                decrement()
            @unknown default:
                break
            }
        }
    }
}

public extension NBStepper where Label == Text {
    /// Creates a stepper with a text label.
    /// - Parameters:
    ///   - title: A string that describes the stepper's purpose.
    ///   - value: A binding to an integer value.
    ///   - range: The closed range of valid values.
    ///   - step: The value to increment or decrement by (default: 1).
    init(_ title: String, value: Binding<Int>, in range: ClosedRange<Int>, step: Int = 1) {
        self.init(value: value, in: range, step: step, accessibilityLabelText: title) {
            Text(title)
        }
    }
}

// MARK: - Private helpers
extension NBStepper {
    private func increment() {
        let newValue = value + step
        if newValue <= range.upperBound {
            value = newValue
        } else {
            value = range.upperBound
        }
    }

    private func decrement() {
        let newValue = value - step
        if newValue >= range.lowerBound {
            value = newValue
        } else {
            value = range.lowerBound
        }
    }

    private func scheduleRepeatTimer(isIncrement: Bool) {
        // Start with 0.5s delay, then repeat every 0.15s
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Check if we're still at a bound; if so, don't start repeating
            if isIncrement && self.value >= self.range.upperBound {
                return
            }
            if !isIncrement && self.value <= self.range.lowerBound {
                return
            }
            self.repeatTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
                if isIncrement {
                    if self.value < self.range.upperBound {
                        self.increment()
                    } else {
                        self.invalidateRepeatTimer()
                    }
                } else {
                    if self.value > self.range.lowerBound {
                        self.decrement()
                    } else {
                        self.invalidateRepeatTimer()
                    }
                }
            }
        }
    }

    private func invalidateRepeatTimer() {
        repeatTimer?.invalidate()
        repeatTimer = nil
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var count = 3
    @Previewable @State var largeValue = 500

    VStack(spacing: 20) {
        NBStepper("Quantity", value: $count, in: 0...10)
        NBStepper(value: $count, in: 0...10) {
            Label("Items", systemImage: "cart")
        }
        NBStepper("Step 5", value: $count, in: 0...100, step: 5)
        NBStepper(value: $largeValue, in: 0...1000) {
            Label("Wide value", systemImage: "rectangle")
        }
        NBStepper(value: $count, in: 0...10) {
            Label("Items", systemImage: "cart")
        }.disabled(true)
        NBStepper("At minimum", value: .constant(0), in: 0...5)
        NBStepper("At maximum", value: .constant(5), in: 0...5)
    }
    .padding()
}
