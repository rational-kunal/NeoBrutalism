import SwiftUI

struct NeoBrutalismPreviewHelper: PreviewModifier {
    private let theme: Theme = .default

    func body(content: Content, context _: Void) -> some View {
        VStack(spacing: 0.0) {
            ZStack {
                theme.background
                    .ignoresSafeArea()
                content
                    .padding()
            }
            .colorScheme(.light)

            ZStack {
                theme.background
                    .ignoresSafeArea()
                content
                    .padding()
            }
            .colorScheme(.dark)
        }
        .environment(\.neoBrutalismTheme, theme)
    }
}
