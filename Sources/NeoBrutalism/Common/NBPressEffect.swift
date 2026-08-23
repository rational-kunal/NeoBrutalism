import SwiftUI

/// A reusable modifier that applies the NeoBrutalism press effect:
/// shadow collapses on press with a spring animation.
/// Respects `accessibilityReduceMotion` — when enabled, state changes are applied instantly.
struct NBPressEffectModifier: ViewModifier {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let elevated: Bool
    let isPressed: Bool
    let roundedCorners: NBCornerSet

    // A quick tap can flip `isPressed` true then false before SwiftUI ever renders the
    // pressed frame, so the spring restarts toward "released" almost as soon as it begins
    // and the press effect never reads as an animation. Holding the pressed visual on
    // screen for at least one spring `response` guarantees both halves are seen.
    @State private var displayedElevated: Bool
    @State private var displayedIsPressed: Bool
    @State private var pressBeganAt: Date?
    @State private var releaseToken = UUID()

    private static let minimumPressDuration: TimeInterval = 0.15

    init(elevated: Bool, isPressed: Bool, roundedCorners: NBCornerSet) {
        self.elevated = elevated
        self.isPressed = isPressed
        self.roundedCorners = roundedCorners
        _displayedElevated = State(initialValue: elevated)
        _displayedIsPressed = State(initialValue: isPressed)
    }

    func body(content: Content) -> some View {
        content
            .nbBox(elevated: displayedElevated, roundedCorners: roundedCorners)
            .animation(reduceMotion ? .none : .interactiveSpring(), value: displayedIsPressed)
            .onChange(of: isPressed) { _, pressed in
                let token = UUID()
                releaseToken = token

                guard !reduceMotion else {
                    displayedElevated = elevated
                    displayedIsPressed = pressed
                    return
                }

                guard pressed else {
                    let elapsed = pressBeganAt.map { -$0.timeIntervalSinceNow } ?? Self.minimumPressDuration
                    let remaining = Self.minimumPressDuration - elapsed
                    guard remaining > 0 else {
                        displayedElevated = elevated
                        displayedIsPressed = false
                        return
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + remaining) {
                        guard releaseToken == token else { return }
                        displayedElevated = elevated
                        displayedIsPressed = false
                    }
                    return
                }

                pressBeganAt = Date()
                displayedElevated = elevated
                displayedIsPressed = true
            }
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
