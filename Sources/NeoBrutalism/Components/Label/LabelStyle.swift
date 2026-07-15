import SwiftUI

public extension LabelStyle where Self == NBLabelStyle {
    /// A label style that applies the neobrutalism aesthetic with bold title text and themed icon color.
    static var neoBrutalism: Self { NBLabelStyle() }
}

/// A `LabelStyle` implementation that applies the neobrutalism design language.
///
/// The style renders the title in bold with consistent spacing. The label
/// inherits foreground color from its container (allowing proper rendering
/// in buttons, menus, and colored surfaces).
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
            configuration.title
                .fontWeight(.bold)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        // Standalone labels
        VStack(alignment: .leading, spacing: 12) {
            Label("Favorites", systemImage: "star.fill")
                .labelStyle(.neoBrutalism)

            Label("Settings", systemImage: "gear")
                .labelStyle(.neoBrutalism)

            Label("Download", systemImage: "arrow.down.circle.fill")
                .labelStyle(.neoBrutalism)
        }

        // Labels inside colored surface (demonstrates inherited color)
        GroupBox("Inside GroupBox") {
            VStack(alignment: .leading, spacing: 12) {
                Label("Favorites", systemImage: "star.fill")
                    .labelStyle(.neoBrutalism)

                Label("Settings", systemImage: "gear")
                    .labelStyle(.neoBrutalism)
            }
        }
        .groupBoxStyle(.neoBrutalism())
    }
    .padding()
}
