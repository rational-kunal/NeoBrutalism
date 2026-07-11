import SwiftUI

/// A reusable modifier that applies the NeoBrutalism press effect:
/// shadow collapses on press with a spring animation.
/// Respects `accessibilityReduceMotion` — when enabled, state changes are applied instantly.
struct NBPressEffectModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let elevated: Bool
    let isPressed: Bool
    let roundedCorners: NBCornerSet

    func body(content: Content) -> some View {
        content
            .nbBox(elevated: elevated, roundedCorners: roundedCorners)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: isPressed)
    }
}

public extension View {
    /// Standard press effect: elevated at rest, shadow collapses while pressed.
    func nbPressEffect(isPressed: Bool, roundedCorners: NBCornerSet = .all) -> some View {
        modifier(NBPressEffectModifier(elevated: !isPressed, isPressed: isPressed, roundedCorners: roundedCorners))
    }

    /// Press effect with caller-resolved elevation, for styles whose variants invert
    /// or suppress the shadow (e.g. `NBButtonStyle.ShadowVariant.reverse`).
    func nbPressEffect(elevated: Bool, isPressed: Bool, roundedCorners: NBCornerSet = .all) -> some View {
        modifier(NBPressEffectModifier(elevated: elevated, isPressed: isPressed, roundedCorners: roundedCorners))
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
