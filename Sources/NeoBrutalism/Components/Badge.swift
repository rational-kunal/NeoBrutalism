import SwiftUI

public struct NBBadge<Content>: View where Content: View {
    public enum BadgeType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    private let type: BadgeType
    private let content: Content

    public init(type: BadgeType = .default, @ViewBuilder content: () -> Content) {
        self.type = type
        self.content = content()
    }

    public var body: some View {
        ZStack {
            content
                .font(.caption)
                .foregroundStyle(textForegroundColor)
        }
        .padding(.horizontal, theme.padding)
        .padding(.vertical, theme.smpadding / 2)
        .background(backgroundColor)
        .nbBox(elevated: false)
    }
}

extension NBBadge {
    private var textForegroundColor: Color {
        switch type {
        case .default:
            return theme.mainText
        case .neutral:
            return theme.text
        }
    }

    private var backgroundColor: Color {
        switch type {
        case .default:
            return theme.main
        case .neutral:
            return theme.bw
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 18.0) {
        NBBadge {
            Text("Xyz")
        }

        NBBadge(type: .neutral) {
            Text("Xyz")
                .font(.caption2)
        }

        NBBadge(type: .default) {
            Text("Xyz")
        }
    }
}
