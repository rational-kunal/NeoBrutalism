import SwiftUI

public struct NBFlatCard<Content>: View where Content: View {
    public enum FlatCardType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    let type: FlatCardType
    let content: Content?

    public init(
        type: FlatCardType = .default,
        @ViewBuilder content: () -> Content
    ) {
        self.type = type
        self.content = content()
    }

    public var body: some View {
        content
            .foregroundStyle(textForegroundColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(theme.padding)
            .background(backgroundColor)
            .nbBox(elevated: false)
    }
}

extension NBFlatCard {
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
    VStack(spacing: 24.0) {
        NBFlatCard {
            Text("some text")
        }

        NBFlatCard(type: .neutral) {
            Text("Some other text")
        }
    }
}
