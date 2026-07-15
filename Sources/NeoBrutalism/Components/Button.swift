import SwiftUI

public extension ButtonStyle where Self == NBButtonStyle {
    /// A neobrutalism button style: a themed fill, thick border, and hard drop shadow that
    /// collapses on press.
    ///
    /// ```swift
    /// Button("Basic Button") {}
    ///     .buttonStyle(.neoBrutalism())
    /// ```
    ///
    /// - Parameters:
    ///   - type: The button's fill. Defaults to `.default`.
    ///   - variant: How the shadow behaves on press. Defaults to `.default`.
    static func neoBrutalism(type: NBButtonStyle.ButtonType = .default, variant: NBButtonStyle.ShadowVariant = .default) -> NBButtonStyle {
        return .init(type: type, variant: variant)
    }
}

/// The neobrutalism button style — see `ButtonStyle.neoBrutalism(type:variant:)`.
public struct NBButtonStyle: ButtonStyle {
    /// The button's fill: `.default` uses the theme's `main` color, `.neutral` uses `bw`.
    public enum ButtonType {
        case `default`, neutral
    }

    /// How the hard drop shadow behaves as the button is pressed.
    public enum ShadowVariant {
        /// The shadow is visible at rest and collapses on press — the standard "pressed
        /// into the surface" feel.
        case `default`
        /// No shadow at any time; the button always renders flush against the surface.
        case noShadow
        /// The shadow is collapsed at rest and pops out on press — an inverted press effect.
        case reverse
    }

    @Environment(\.nbTheme) private var theme

    init(type: ButtonType = .default, variant: ShadowVariant = .default) {
        self.type = type
        self.variant = variant
    }

    let type: ButtonType
    let variant: ShadowVariant

    public func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        let elevated: Bool = {
            switch variant {
            case .default: return !isPressed
            case .noShadow: return false
            case .reverse: return isPressed
            }
        }()

        return configuration.label
            .padding(theme.padding)
            .foregroundStyle(textForegroundColor)
            .background(backgroundColor)
            .nbPressEffect(elevated: elevated, isPressed: isPressed)
            .nbDisabledEffect()
    }

    private var textForegroundColor: Color {
        switch type {
        case .default: return theme.mainText
        case .neutral: return theme.text
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .default: return theme.main
        case .neutral: return theme.bw
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(alignment: .leading, spacing: 20) {
        Button("Basic Button") {}
            .buttonStyle(.neoBrutalism())
        
        Button("Disabled Button") {}
            .disabled(true)
            .buttonStyle(.neoBrutalism())

        Button {} label: {
            Label("With Icon", systemImage: "star.fill")
        }
        .buttonStyle(.neoBrutalism())

        // Multiline Text
        Button {} label: {
            Text("This is a button\nwith multiple lines")
                .multilineTextAlignment(.center)
        }
        .buttonStyle(.neoBrutalism())

        Button("Neutral Reverse") {}
            .buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
    }
    .padding()
}
