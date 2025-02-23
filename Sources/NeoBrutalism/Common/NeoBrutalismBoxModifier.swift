import SwiftUI

struct NeoBrutalismBoxModifier: NeoBrutalismBase, ViewModifier {
    public let elevated: Bool

    func body(content: Content) -> some View {
        content
            .background {
                Color.white
            }
            .cornerRadius(cornerRadius)
            .shadow(color: .black,
                    radius: 0.0,
                    x: elevated ? shadowOffset : 0.0,
                    y: elevated ? shadowOffset : 0.0)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Theme.standard.border, lineWidth: strokeWidth)
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
            .background { Color.orange }
            .neoBrutalismBox()

        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .neoBrutalismBox(elevated: false)

    }.padding()
}
