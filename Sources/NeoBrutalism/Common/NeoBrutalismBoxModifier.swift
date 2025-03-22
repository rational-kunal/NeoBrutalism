import SwiftUI

struct NeoBrutalismBoxModifier: ViewModifier {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    public let elevated: Bool

    func body(content: Content) -> some View {
        content
            .foregroundStyle(theme.text)
            .cornerRadius(theme.borderRadius)
            .shadow(
                color: theme.border,
                radius: 0.0,
                x: elevated ? theme.boxShadowX : 0.0,
                y: elevated ? theme.boxShadowY : 0.0
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.borderRadius)
                    .stroke(Color.black, lineWidth: theme.borderWidth)
            )
    }
}

public extension View {
    func neoBrutalismBox(elevated: Bool = true) -> some View {
        modifier(NeoBrutalismBoxModifier(elevated: elevated))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    VStack(spacing: 12.0) {
        // Needs default background
        Text("Harry Potter")
            .padding(8.0)
            .neoBrutalismBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .neoBrutalismBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .neoBrutalismBox(elevated: false)

    }.padding()
}
