import SwiftUI

public struct Badge<Content>: View where Content: View {
    public enum BadgeType {
        case `default`, neutral
    }

    @Environment(\.neoBrutalismTheme) var theme: Theme

    private let type: BadgeType
    private let content: Content

    public init(type: BadgeType = .default, @ViewBuilder content: () -> Content) {
        self.type = type
        self.content = content()
    }

    private var textForegroundColor: Color {
        switch type {
        case .default:
            return theme.mainText
        case .neutral:
            return theme.text
        }
    }

    public var body: some View {
        ZStack {
            content
                .font(.caption)
                .foregroundStyle(textForegroundColor)
        }
        .padding(.horizontal, theme.padding)
        .padding(.vertical, 2.0)
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
    VStack(spacing: 18.0) {
        Badge {
            Text("Xyz")
        }

        Badge(type: .neutral) {
            Text("Xyz")
                .font(.caption2)
        }

        Badge(type: .default) {
            Text("Xyz")
        }
    }
}
