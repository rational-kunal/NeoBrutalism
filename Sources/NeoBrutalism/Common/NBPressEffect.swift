import SwiftUI

/// A reusable modifier that applies the NeoBrutalism press effect:
/// shadow collapses on press with a spring animation.
/// Respects `accessibilityReduceMotion` — when enabled, state changes are applied instantly.
struct NBPressEffectModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let isPressed: Bool

    func body(content: Content) -> some View {
        content
            .nbBox(elevated: !isPressed)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: isPressed)
    }
}

public extension View {
    /// Applies the NeoBrutalism press effect: shadow collapses when pressed,
    /// with a spring animation (or instant if reduce-motion is enabled).
    func nbPressEffect(isPressed: Bool) -> some View {
        modifier(NBPressEffectModifier(isPressed: isPressed))
    }
}

/// Returns the appropriate animation for the press effect, respecting reduce-motion.
/// Use this in contexts where `withAnimation` is needed (e.g., toggle actions)
/// rather than the declarative `.animation()` modifier.
func nbPressAnimation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? .none : .interactiveSpring()
}

/// Returns a punchier, more energetic spring for elements that pop into view — dropdowns,
/// popovers, tooltips. Unlike `nbPressAnimation`'s tightly-damped settle, this slightly
/// overshoots before settling, reading as a tactile "stamp" rather than a soft fade-in.
/// Respects reduce-motion.
func nbPopAnimation(reduceMotion: Bool) -> Animation? {
    reduceMotion ? .none : .spring(response: 0.32, dampingFraction: 0.58, blendDuration: 0)
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var isPressed = false

    VStack(spacing: 24) {
        Text("Press Me")
            .padding(12)
            .background(Color.orange)
            .nbPressEffect(isPressed: isPressed)

        Button(isPressed ? "Release" : "Press") {
            isPressed.toggle()
        }
    }
    .padding()
}
