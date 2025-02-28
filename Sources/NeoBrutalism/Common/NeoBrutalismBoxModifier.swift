import SwiftUI

struct NeoBrutalismBoxModifier: ViewModifier {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    public let elevated: Bool

    func body(content: Content) -> some View {
        content
            .background {
                theme.blank
            }
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

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 12.0) {
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
