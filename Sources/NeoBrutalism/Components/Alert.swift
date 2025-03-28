import SwiftUI

public struct Alert<Icon, Head, Desc>: View where Icon: View, Head: View, Desc: View {
    public enum AlertType {
        case `default`, neutral
    }

    @Environment(\.neoBrutalismTheme) var theme: Theme

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
                icon
                    .frame(minWidth: theme.size)
                    .foregroundStyle(textForegroundColor)
                    .padding(.top, 1.0)
                VStack(alignment: .leading) {
                    head
                        .foregroundStyle(textForegroundColor)
                        .bold()
                    desc
                        .foregroundStyle(textForegroundColor)
                }
            }
        }
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
        .neoBrutalismBox()
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    VStack(spacing: 18.0) {
        Alert {
            Text("Desc")
        } head: {
            Text("Alert")
        }

        Alert(type: .neutral) {
            Text("Desc")
        } icon: {
            Image(systemName: "questionmark")
        } head: {
            Text("Head")
        }

        Alert {
            Text("Desc")
        } icon: {
            EmptyView()
        } head: {
            Text("Head")
        }
    }
}
