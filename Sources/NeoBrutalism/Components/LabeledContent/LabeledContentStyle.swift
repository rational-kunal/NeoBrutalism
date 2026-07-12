import SwiftUI

public extension LabeledContentStyle where Self == NBLabeledContentStyle {
    static var neoBrutalism: NBLabeledContentStyle { .init() }
}

/// A neo-brutalism styled `LabeledContentStyle` for settings-row style label/value pairs.
///
/// Displays the label on the left with regular weight and the value on the right with bold weight,
/// both using the theme's text color for proper contrast.
///
/// ```swift
/// LabeledContent("Username", value: "johndoe")
///     .labeledContentStyle(.neoBrutalism)
/// ```
public struct NBLabeledContentStyle: LabeledContentStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundStyle(theme.text)
                .fontWeight(.regular)

            Spacer()

            configuration.content
                .foregroundStyle(theme.text)
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

        // Inside a neutral GroupBox (demonstrates proper contrast)
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
