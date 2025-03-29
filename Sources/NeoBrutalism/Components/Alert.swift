import SwiftUI

public struct NBAlert<Icon, Head, Desc>: View where Icon: View, Head: View, Desc: View {
    public enum AlertType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    private let type: AlertType

    private let desc: Desc
    private let icon: Icon
    private let head: Head

    private var textForegroundColor: Color {
        switch type {
        case .default:
            return theme.mainText
        case .neutral:
            return theme.text
        }
    }

    public init(
        type: AlertType = .default, @ViewBuilder desc: () -> Desc,
        @ViewBuilder icon: () -> Icon = { EmptyView() }, @ViewBuilder head: () -> Head
    ) {
        self.type = type
        self.head = head()
        self.icon = icon()
        self.desc = desc()
    }

    public var body: some View {
        ZStack {
            HStack(alignment: .top) {
                iconWrappedView

                VStack(alignment: .leading) {
                    head
                        .bold()
                    desc
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.padding)
        .foregroundStyle(textForegroundColor)
        .background(backgroundColor)
        .nbBox()
    }
}

extension NBAlert {
    var iconWrappedView: some View {
        icon
            .frame(minWidth: theme.size)
            .foregroundStyle(textForegroundColor)
            .padding(.top, 1.0)
    }

    var backgroundColor: Color {
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
        NBAlert {
            Text("Desc")
        } head: {
            Text("Alert")
        }

        NBAlert(type: .neutral) {
            Text("Desc")
        } icon: {
            Image(systemName: "questionmark")
        } head: {
            Text("Head")
        }

        NBAlert {
            Text("Desc")
        } icon: {
            EmptyView()
        } head: {
            Text("Head")
        }
    }
}
