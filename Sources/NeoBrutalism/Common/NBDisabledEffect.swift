import SwiftUI

struct NBDisabledEffect: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content.opacity(isEnabled ? 1.0 : 0.5)
    }
}

extension View {
    func nbDisabledEffect() -> some View {
        modifier(NBDisabledEffect())
    }
}
