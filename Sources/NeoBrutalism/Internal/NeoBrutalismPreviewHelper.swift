import SwiftUI

struct NBPreviewHelper: PreviewModifier {
    private let theme: NBTheme = .default

    func body(content: Content, context _: Void) -> some View {
        VStack(spacing: 0.0) {
            ZStack {
                theme.background
                    .ignoresSafeArea()
                content
                    .padding()
            }
        }
        .environment(\.nbTheme, theme)
    }
}
