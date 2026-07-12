import SwiftUI

public extension View {
    /// Themes the navigation bar for this screen: opaque `theme.background` bar with the
    /// standard border-color divider. Apply inside a `NavigationStack`, on the screen content.
    ///
    /// ```swift
    /// NavigationStack {
    ///     ContentView()
    ///         .navigationTitle("Spells")
    ///         .nbNavigationBar()
    /// }
    /// .neoBrutalism()
    /// ```
    ///
    /// **Known limit:** SwiftUI provides no per-screen API for the title font. Large bold
    /// titles already fit the style; if you want a custom title font, use this pattern:
    ///
    /// ```swift
    /// .toolbar {
    ///     ToolbarItem(placement: .principal) {
    ///         Text("Custom Title").bold()
    ///     }
    /// }
    /// ```
    ///
    /// - Note: Toolbar buttons inside a themed screen automatically pick up `NBButtonStyle`
    ///   from the root `.neoBrutalism()` modifier. If styles reset in your toolbar context,
    ///   explicitly apply `.buttonStyle(.neoBrutalism(type: .neutral))` to the toolbar item.
    func nbNavigationBar() -> some View {
        modifier(NBNavigationBarModifier())
    }
}

struct NBNavigationBarModifier: ViewModifier {
    @Environment(\.nbTheme) private var theme: NBTheme

    func body(content: Content) -> some View {
        content
            .toolbarBackground(theme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - Preview

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    NavigationStack {
        VStack {
            Text("Content goes here")
        }
        .navigationTitle("Navigation Example")
        .nbNavigationBar()
    }
}
