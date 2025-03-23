import SwiftUI

public struct TextSkeleton: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    public init() {}

    public var body: some View {
        Rectangle()
            .fill(theme.clear)
            .neoBrutalismBox(elevated: false)
            .frame(width: .infinity, height: theme.size)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 12.0) {
        TextSkeleton()

        TextSkeleton()
            .frame(width: 120, height: 20.0)
    }
}
