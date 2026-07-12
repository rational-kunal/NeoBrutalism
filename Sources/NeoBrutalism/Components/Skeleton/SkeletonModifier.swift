import SwiftUI

public extension View {
    /// Replaces this view with a pulsing skeleton box of the same size while `active`.
    ///
    /// When `active` is true, the view is hidden and replaced with a pulsing skeleton
    /// placeholder that takes up the same space. When `active` is false, the view renders
    /// normally.
    ///
    /// ```swift
    /// ProfileRow(user: user).nbSkeleton(active: isLoading)
    /// ```
    ///
    /// - Parameter active: Whether to show the skeleton placeholder.
    /// - Returns: The view with skeleton behavior applied.
    func nbSkeleton(active: Bool) -> some View {
        _NBSkeletonModifier(active: active) { self }
    }
}

// MARK: - Private Implementation

private struct _NBSkeletonModifier<Content: View>: View {
    let active: Bool
    let content: Content

    @Environment(\.nbTheme) private var theme

    init(active: Bool, @ViewBuilder content: () -> Content) {
        self.active = active
        self.content = content()
    }

    var body: some View {
        if active {
            content
                .hidden()
                .overlay(
                    RoundedRectangle(cornerRadius: theme.borderRadius)
                        .fill(theme.bw)
                        .modifier(NBSkeletonPulse())
                        .nbBox(elevated: false)
                )
                .accessibilityLabel("Loading")
                .accessibilityAddTraits(.updatesFrequently)
        } else {
            content
        }
    }
}
