import SwiftUI

public extension LabeledContentStyle where Self == NBLabeledContentStyle {
    static var neoBrutalism: NBLabeledContentStyle { .init() }
}

/// A neo-brutalism styled `LabeledContentStyle` for settings-row style label/value pairs.
///
/// Displays the label on the left with regular weight and the value on the right with bold
/// weight. Like ``NBLabelStyle``, the row inherits its foreground color from the container
/// rather than pinning one, so it stays legible on whatever surface it lands on.
///
/// ```swift
/// LabeledContent("Username", value: "johndoe")
///     .labeledContentStyle(.neoBrutalism)
/// ```
public struct NBLabeledContentStyle: LabeledContentStyle {
    public func makeBody(configuration: Configuration) -> some View {
        // Deliberately no `foregroundStyle` here. Pinning `theme.text` overrode the
        // `theme.mainText` that surfaces like `NBGroupBoxStyle(.default)` set for their
        // subtree, which in dark mode painted near-white text on the light `main` fill —
        // about 1.87:1, well under the 3:1 floor.
        HStack {
            configuration.label
                .fontWeight(.regular)

            Spacer()

            configuration.content
                .fontWeight(.bold)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 20) {
        // Standalone labeled content
        VStack(spacing: 12) {
            LabeledContent("Username", value: "johndoe")
                .labeledContentStyle(.neoBrutalism)

            LabeledContent("Email", value: "user@example.com")
                .labeledContentStyle(.neoBrutalism)

            LabeledContent("Plan", value: "Pro")
                .labeledContentStyle(.neoBrutalism)
        }

        // Inside a `main`-filled GroupBox — the row must pick up the card's `mainText`
        GroupBox {
            VStack(spacing: 12) {
                LabeledContent("Username", value: "johndoe")
                    .labeledContentStyle(.neoBrutalism)

                LabeledContent("Email", value: "user@example.com")
                    .labeledContentStyle(.neoBrutalism)

                LabeledContent("Plan", value: "Pro")
                    .labeledContentStyle(.neoBrutalism)
            }
        }
        .groupBoxStyle(.neoBrutalism())
    }
    .padding()
}
