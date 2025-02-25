import SwiftUI

public struct Button<Content>: View where Content: View {
    public enum ButtonType {
        case `default`, neutral
    }

    public enum ButtonVariant {
        case `default`, noShadow, reverse
    }

    @Environment(\.neoBrutalismTheme) var theme: Theme

    @State private var elevated: Bool

    private let type: ButtonType
    private let variant: ButtonVariant
    private let content: Content
    private let action: () -> Void

    public init(type: ButtonType = .default, variant: ButtonVariant = .default, @ViewBuilder content: () -> Content, action: @escaping () -> Void) {
        self.type = type
        self.variant = variant
        self.content = content()
        self.action = action
        self.elevated = variant == .default
    }

    private var textForegroundColor: Color {
        switch type {
        case .default:
            theme.mainText
        case .neutral:
            theme.text
        }
    }

    public var body: some View {
        ZStack {
            content
                .foregroundStyle(textForegroundColor)
        }
        .padding(theme.padding)
        .contentShape(Rectangle())
        .onLongPressGesture(minimumDuration: 0.0,
                            perform: {},
                            onPressingChanged: { pressed in
                                withAnimation(.interactiveSpring) {
                                    updateElevention(isPressed: pressed)
                                }
                                if !pressed {
                                    action()
                                }
                            })
        .background(content: {
            switch type {
            case .default:
                theme.main
            case .neutral:
                theme.bw
            }
        })
        .neoBrutalismBox(elevated: elevated)
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

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 18.0) {
        Button {
            Text("Accio")
        } action: {
            print("OPEN")
        }
        
        Button(variant: .reverse) {
            Text("Accio")
        } action: {
            print("OPEN")
        }
        
        Button(type: .neutral, variant: .noShadow) {
            Image(systemName: "plus")
        } action: {
            print("OPEN")
        }

        Spacer()
    }.padding()
}
