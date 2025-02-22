import SwiftUI

struct ElevatedBoxModifier: NeoBrutalismBase, ViewModifier {

    func body(content: Content) -> some View {
        content
            .background {
                Color.white
            }
            .cornerRadius(cornerRadius)
            .shadow(color: .black, radius: 0.0, x: shadowOffset, y: shadowOffset)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Theme.standard.border, lineWidth: strokeWidth)
            )
    }
}

extension View {
    public func elevatedBox() -> some View {
        modifier(ElevatedBoxModifier())
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 12.0) {
        Text("Harry Potter")
            .padding(8.0)
            .background { Color.orange }
            .elevatedBox()

    }.padding()
}

