import SwiftUI

public extension LabeledContentStyle where Self == NBLabeledContentStyle {
    static var neoBrutalism: NBLabeledContentStyle { .init() }
}

/// A neo-brutalism styled `LabeledContentStyle` for settings-row style label/value pairs.
///
/// Displays the label on the left with regular weight and the value on the right with bold weight,
/// using themed colors and horizontal padding.
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
                .foregroundStyle(theme.main)
                .fontWeight(.bold)
        }
        .padding(.horizontal, theme.padding)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 20) {
        LabeledContent("Username", value: "johndoe")
            .labeledContentStyle(.neoBrutalism)

        LabeledContent("Email", value: "user@example.com")
            .labeledContentStyle(.neoBrutalism)

        LabeledContent("Plan", value: "Pro")
            .labeledContentStyle(.neoBrutalism)
    }
}
