import SwiftUI

public extension ButtonStyle where Self == NBButtonStyle {
    static func neoBrutalism(type: NBButtonStyle.ButtonType = .default, variant: NBButtonStyle.ShadowVariant = .default) -> NBButtonStyle {
        return .init(type: type, variant: variant)
    }
}

public struct NBButtonStyle: ButtonStyle {
    public enum ButtonType {
        case `default`, neutral
    }

    public enum ShadowVariant {
        case `default`, noShadow, reverse
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
            .animation(.interactiveSpring(), value: isPressed)
            .nbBox(elevated: elevated)
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
