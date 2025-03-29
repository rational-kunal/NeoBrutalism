import SwiftUI

public struct NBButton<Content>: View where Content: View {
    public enum ButtonType {
        case `default`, neutral
    }

    public enum ShadowVariant {
        case `default`, noShadow, reverse
    }

    @Environment(\.nbTheme) var theme: NBTheme

    @State private var elevated: Bool

    private let type: ButtonType
    private let variant: ShadowVariant
    private let content: Content
    private let action: () -> Void

    public init(
        type: ButtonType = .default, variant: ShadowVariant = .default,
        @ViewBuilder content: () -> Content, action: @escaping () -> Void
    ) {
        self.type = type
        self.variant = variant
        self.content = content()
        self.action = action
        elevated = variant == .default
    }

    public var body: some View {
        ZStack {
            content
                .foregroundStyle(textForegroundColor)
        }
        .padding(theme.padding)
        .contentShape(Rectangle())
        .onLongPressGesture(
            minimumDuration: 0.0,
            perform: {},
            onPressingChanged: { pressed in
                withAnimation(.interactiveSpring) {
                    updateElevention(isPressed: pressed)
                }
                if !pressed {
                    action()
                }
            }
        )
        .background(backgroundColor)
        .nbBox(elevated: elevated)
    }

    private func updateElevention(isPressed: Bool) {
        switch variant {
        case .default:
            elevated = isPressed ? false : true
        case .noShadow:
            elevated = false
        case .reverse:
            elevated = isPressed ? true : false
        }
        print(variant, elevated)
    }
}

extension NBButton {
    private var textForegroundColor: Color {
        switch type {
        case .default:
            theme.mainText
        case .neutral:
            theme.text
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .default:
            theme.main
        case .neutral:
            theme.bw
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 18.0) {
        NBButton {
            Text("Accio")
        } action: {
            print("OPEN")
        }

        NBButton(variant: .reverse) {
            Text("Accio")
        } action: {
            print("OPEN")
        }

        NBButton(type: .neutral, variant: .noShadow) {
            Image(systemName: "plus")
        } action: {
            print("OPEN")
        }
    }.padding()
}
