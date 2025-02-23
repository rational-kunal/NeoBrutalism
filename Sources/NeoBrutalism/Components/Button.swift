import SwiftUI

public struct Button<Content>: NeoBrutalismBase, View where Content: View {
    public enum ButtonType {
        case primary, neutral
    }

    public enum ButtonVariant {
        case `default`, noShadow, reverse
    }

    @State private var elevated: Bool

    private let type: ButtonType
    private let variant: ButtonVariant
    private let content: Content
    private let action: () -> Void

    public init(type: ButtonType = .primary, variant: ButtonVariant = .default, @ViewBuilder content: () -> Content, action: @escaping () -> Void) {
        self.type = type
        self.variant = variant
        self.content = content()
        self.action = action
        self.elevated = variant == .default
    }

    public var body: some View {
        ZStack {
            content
        }
        .padding(padding)
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
            case .neutral:
                Theme.standard.clear
            case .primary:
                Theme.standard.main
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
