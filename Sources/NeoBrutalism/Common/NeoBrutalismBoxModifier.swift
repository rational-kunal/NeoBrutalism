import SwiftUI

struct NBBoxModifier: ViewModifier {
    @Environment(\.nbTheme) var theme: NBTheme

    public let elevated: Bool

    func body(content: Content) -> some View {
        content
//            .foregroundStyle(theme.text)
            .cornerRadius(theme.borderRadius)
            .shadow(
                color: theme.border,
                radius: 0.0,
                x: elevated ? theme.boxShadowX : 0.0,
                y: elevated ? theme.boxShadowY : 0.0
            )
            .overlay(
                RoundedRectangle(cornerRadius: theme.borderRadius, style: .circular)
                    .stroke(theme.border, lineWidth: theme.borderWidth)
            )
    }
}

public extension View {
    func nbBox(elevated: Bool = true) -> some View {
        modifier(NBBoxModifier(elevated: elevated))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 12.0) {
        // Needs default background
        Text("Harry Potter")
            .padding(8.0)
            .nbBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .nbBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .nbBox(elevated: false)

    }.padding()
}
