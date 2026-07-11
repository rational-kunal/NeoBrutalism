import SwiftUI

public extension LabelStyle where Self == NBLabelStyle {
    /// A label style that applies the neobrutalism aesthetic with bold title text and themed icon color.
    static var neoBrutalism: Self { NBLabelStyle() }
}

/// A ``LabelStyle`` implementation that applies the neobrutalism design language.
///
/// The style renders the title in bold with the theme's `text` color and
/// tints the icon using the same color. It does not add borders or shadows,
/// making it suitable for inline label usage.
///
/// ```swift
/// Label("Favorites", systemImage: "star.fill")
///     .labelStyle(.neoBrutalism)
/// ```
public struct NBLabelStyle: LabelStyle {
    @Environment(\.nbTheme) private var theme

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: theme.smspacing) {
            configuration.icon
                .foregroundStyle(theme.text)
            configuration.title
                .foregroundStyle(theme.text)
                .fontWeight(.bold)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        Label("Favorites", systemImage: "star.fill")
            .labelStyle(.neoBrutalism)

        Label("Settings", systemImage: "gear")
            .labelStyle(.neoBrutalism)

        Label("Download", systemImage: "arrow.down.circle.fill")
            .labelStyle(.neoBrutalism)
    }
    .padding()
}
