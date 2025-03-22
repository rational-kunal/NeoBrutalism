import SwiftUI

public struct TabsList<Content: View>: View {
    @Environment(\.neoBrutalismTheme) private var theme: Theme
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        HStack(spacing: theme.smspacing) {
            content.frame(maxWidth: .infinity)
        }
        .padding(theme.smpadding)
        .background(theme.main)
        .neoBrutalismBox(elevated: false)
    }
}
