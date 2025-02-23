import SwiftUI

public struct Alert<Icon, Head, Desc>: NeoBrutalismBase, View where Icon: View, Head: View, Desc: View {
    public enum AlertType {
        case neutral
        case primary
        case danger
    }

    private let type: AlertType

    private let desc: Desc
    private let icon: Icon
    private let head: Head

    private var textForegroundColor: Color {
        switch type {
        case .neutral:
            return Theme.standard.text
        case .primary:
            return Theme.standard.text
        case .danger:
            return Theme.standard.textDark
        }
    }

    public init(type: AlertType = .neutral, @ViewBuilder desc: () -> Desc, @ViewBuilder icon: () -> Icon = { Image(systemName: "terminal") }, @ViewBuilder head: () -> Head) {
        self.type = type
        self.head = head()
        self.icon = icon()
        self.desc = desc()
    }

    public var body: some View {
        ZStack {
            HStack(alignment: .top) {
                icon
                    .frame(minWidth: size)
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
        .padding(padding)
        .background(content: {
            switch type {
            case .neutral:
                return Theme.standard.clear
            case .primary:
                return Theme.standard.main
            case .danger:
                return Theme.standard.dark
            }
        })
        .elevatedBox()
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

        Alert(type: .primary) {
            Text("Desc")
        } icon: {
            EmptyView()
        } head: {
            Text("Head")
        }

        Spacer()
    }.padding()
}
