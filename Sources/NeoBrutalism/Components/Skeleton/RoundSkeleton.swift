import SwiftUI

public struct NBRoundSkeleton: View {
    @Environment(\.nbTheme) var theme: NBTheme

    public init() {}

    public var body: some View {
        Circle()
            .fill(theme.clear)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: theme.borderWidth)
            )
            .padding(theme.smpadding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 12.0) {
        NBRoundSkeleton()

        NBRoundSkeleton()
            .frame(width: 120, height: 120)
    }
}
