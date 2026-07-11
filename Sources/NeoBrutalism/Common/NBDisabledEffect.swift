import SwiftUI

struct NBDisabledEffect: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        content
            // Flatten shadow + fill + border into one layer before dimming, otherwise the
            // offset hard-shadow (drawn behind the box) bleeds through the translucent
            // front face instead of just peeking out at the edges.
            .compositingGroup()
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

extension View {
    func nbDisabledEffect() -> some View {
        modifier(NBDisabledEffect())
    }
}
