import SwiftUI

public struct Alert<Icon, Head, Desc>: View where Icon: View, Head: View, Desc: View {

    public enum AlertType {
        case `default`, danger
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
        case .danger:
            return theme.text
        }
    }

    public init(type: AlertType = .default, @ViewBuilder desc: () -> Desc, @ViewBuilder icon: () -> Icon = { Image(systemName: "terminal") }, @ViewBuilder head: () -> Head) {
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
            case .danger:
                theme.bw
            }
        })
        .neoBrutalismBox()
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 18.0) {
        Alert {
            Text("Desc")
        } head: {
            Text("Alert")
        }

        Alert(type: .danger) {
            Text("Desc")
        } icon: {
            Image(systemName: "questionmark")
        } head: {
            Text("Head")
        }

        Alert() {
            Text("Desc")
        } icon: {
            EmptyView()
        } head: {
            Text("Head")
        }

        Spacer()
    }.padding()
}
