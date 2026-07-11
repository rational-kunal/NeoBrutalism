import SwiftUI

/// A neobrutalism-styled menu style.
///
/// Applies the characteristic thick border, box shadow, and theme colors
/// to the menu's trigger label, giving it the appearance of a themed button
/// with a trailing chevron indicator.
///
/// - Important: `MenuStyle` can only style the *trigger* — the dropdown that appears on tap is
///   drawn by UIKit and stays iOS-native. If you need the popup itself themed too, use
///   ``NBMenu`` instead, which presents its own fully-styled dropdown.
///
/// Usage:
/// ```swift
/// Menu("Options") {
///     Button("Edit") {}
///     Button("Delete") {}
/// }
/// .menuStyle(.neoBrutalism)
/// ```
public struct NBMenuStyle: MenuStyle {
    @Environment(\.nbTheme) private var theme

    public func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .foregroundStyle(theme.text)
            .padding(theme.padding)
            .background(theme.bw)
            .nbBox()
    }
}

public extension MenuStyle where Self == NBMenuStyle {
    /// A neobrutalism menu style with thick borders and box shadow.
    static var neoBrutalism: NBMenuStyle { .init() }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        Menu("Options") {
            Button("Edit", action: {})
            Button("Delete", action: {})
            Button("Share", action: {})
        }
        .menuStyle(.neoBrutalism)

        Menu {
            Button("Cut", action: {})
            Button("Copy", action: {})
            Button("Paste", action: {})
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
        .menuStyle(.neoBrutalism)
    }
    .padding()
}
