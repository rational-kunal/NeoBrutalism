import SwiftUI

public struct NBTextSkeleton: View {
    @Environment(\.nbTheme) var theme: NBTheme

    public init() {}

    public var body: some View {
        Rectangle()
            .fill(theme.bw)
            .nbBox(elevated: false)
            .frame(maxWidth: .infinity)
            .frame(height: theme.size)
            .modifier(NBSkeletonPulse())
            .accessibilityHidden(true)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 12.0) {
        NBTextSkeleton()

        NBTextSkeleton()
            .frame(width: 120, height: 20.0)
    }
}
