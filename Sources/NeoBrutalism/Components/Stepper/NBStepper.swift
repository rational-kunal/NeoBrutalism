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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @Binding private var value: Int
    private let range: ClosedRange<Int>
    private let label: Label

    @State private var isMinusPressed = false
    @State private var isPlusPressed = false

    /// Creates a stepper with a custom label.
    /// - Parameters:
    ///   - value: A binding to an integer value.
    ///   - range: The closed range of valid values.
    ///   - label: A view that describes the stepper's purpose.
    public init(value: Binding<Int>, in range: ClosedRange<Int>, @ViewBuilder label: () -> Label) {
        _value = value
        self.range = range
        self.label = label()
    }

    public var body: some View {
        HStack(spacing: theme.spacing) {
            label
                .foregroundStyle(theme.text)

            Spacer()

            HStack(spacing: 0) {
                // Minus button
                Button {
                    if value > range.lowerBound {
                        value -= 1
                    }
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
                        .onChanged { _ in isMinusPressed = true }
                        .onEnded { _ in isMinusPressed = false }
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
                    if value < range.upperBound {
                        value += 1
                    }
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
                        .onChanged { _ in isPlusPressed = true }
                        .onEnded { _ in isPlusPressed = false }
                )
            }
            .fixedSize(horizontal: true, vertical: true)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: isMinusPressed)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: isPlusPressed)
            .nbBox(elevated: !(isMinusPressed || isPlusPressed))
        }
        .nbDisabledEffect()
    }
}

public extension NBStepper where Label == Text {
    /// Creates a stepper with a text label.
    /// - Parameters:
    ///   - title: A string that describes the stepper's purpose.
    ///   - value: A binding to an integer value.
    ///   - range: The closed range of valid values.
    init(_ title: String, value: Binding<Int>, in range: ClosedRange<Int>) {
        self.init(value: value, in: range) {
            Text(title)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var count = 3

    VStack(spacing: 20) {
        NBStepper("Quantity", value: $count, in: 0...10)
        NBStepper(value: $count, in: 0...10) {
            Label("Items", systemImage: "cart")
        }
        NBStepper(value: $count, in: 0...10) {
            Label("Items", systemImage: "cart")
        }.disabled(true)
        NBStepper("At minimum", value: .constant(0), in: 0...5)
        NBStepper("At maximum", value: .constant(5), in: 0...5)
    }
    .padding()
}
