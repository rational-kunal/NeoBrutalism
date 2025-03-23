import SwiftUI

public struct RoundSkeleton: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    public init() {}

    public var body: some View {
        Circle()
            .fill(theme.clear)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: theme.borderWidth)
            )
            .padding(theme.smpadding)
            .frame(width: .infinity, height: .infinity)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 12.0) {
        RoundSkeleton()

        RoundSkeleton()
            .frame(width: 120, height: 120)
    }
}
