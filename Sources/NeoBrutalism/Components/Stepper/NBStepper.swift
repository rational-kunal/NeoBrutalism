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
    @State private var repeatDelay: DispatchWorkItem?

    /// Creates a stepper with a custom label.
    /// - Parameters:
    ///   - value: A binding to an integer value.
    ///   - range: The closed range of valid values.
    ///   - step: The value to increment or decrement by (default: 1).
    ///   - accessibilityLabelText: Optional text VoiceOver reads for this control, in place of
    ///     inferring one from `label`. Defaults to `nil`.
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
                            guard !isMinusPressed else { return }
                            isMinusPressed = true
                            startRepeating(isIncrement: false)
                        }
                        .onEnded { _ in
                            isMinusPressed = false
                            stopRepeating()
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
                            guard !isPlusPressed else { return }
                            isPlusPressed = true
                            startRepeating(isIncrement: true)
                        }
                        .onEnded { _ in
                            isPlusPressed = false
                            stopRepeating()
                        }
                )
            }
            .fixedSize(horizontal: true, vertical: true)
            .nbPressEffect(isPressed: isMinusPressed || isPlusPressed)
        }
        .nbDisabledEffect()
        // `stopRepeating()` is otherwise only reachable from `DragGesture.onEnded`, which
        // never fires if the view goes away mid-hold (or a parent scroll view claims the
        // gesture). Without this the repeat `Timer` keeps firing — and keeps writing to the
        // binding — long after the stepper is gone.
        .onDisappear {
            isMinusPressed = false
            isPlusPressed = false
            stopRepeating()
        }
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

    /// Starts press-and-hold auto-repeat: after a 0.5s hold the step repeats every 0.15s until
    /// the finger lifts or the range bound is hit. The 0.5s delay is a cancellable
    /// `DispatchWorkItem` (not a bare `asyncAfter`) so an early release stops it — otherwise the
    /// delayed closure would still fire and start repeating with no finger down.
    private func startRepeating(isIncrement: Bool) {
        let delay = DispatchWorkItem {
            repeatTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
                repeatStep(isIncrement: isIncrement)
            }
        }
        repeatDelay = delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: delay)
    }

    /// Steps once for the repeat timer, stopping the timer when it reaches the range bound so it
    /// doesn't keep firing uselessly against a clamped value.
    private func repeatStep(isIncrement: Bool) {
        if isIncrement {
            guard value < range.upperBound else { return stopRepeating() }
            increment()
        } else {
            guard value > range.lowerBound else { return stopRepeating() }
            decrement()
        }
    }

    /// Cancels both the pending 0.5s delay and any running repeat timer.
    private func stopRepeating() {
        repeatDelay?.cancel()
        repeatDelay = nil
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
