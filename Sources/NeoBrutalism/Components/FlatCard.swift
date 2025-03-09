import SwiftUI

public struct FlatCard<Content>: View where Content: View {
    public enum FlatCardType {
        case `default`, neutral
    }

    @Environment(\.neoBrutalismTheme) var theme: Theme

    let type: FlatCardType
    let content: Content?

    public init(
        type: FlatCardType = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.type = type
        self.content = content()
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
        content
            .foregroundStyle(textForegroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(theme.padding)
            .background(content: {
                switch type {
                case .default:
                    theme.main
                case .neutral:
                    theme.bw
                }
            })
            .neoBrutalismBox(elevated: false)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    VStack(spacing: 24.0) {
        FlatCard {
            Text("some text")
        }

        FlatCard(type: .neutral) {
            Text("Some other text")
        }
    }
}
