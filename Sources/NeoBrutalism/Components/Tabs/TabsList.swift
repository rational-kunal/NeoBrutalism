import SwiftUI

public struct NBTabsList<Content: View>: View {
    @Environment(\.nbTheme) private var theme: NBTheme
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: theme.smspacing) {
            content.frame(maxWidth: .infinity)
        }
        .padding(theme.smpadding)
        .foregroundStyle(theme.mainText)
        .background(theme.main)
        .nbBox(elevated: false)
    }
}
