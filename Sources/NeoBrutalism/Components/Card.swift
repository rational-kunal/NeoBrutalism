import SwiftUI

public struct Card<Header, Main, Footer>: View where Header: View, Main: View, Footer: View {
    public enum CardType {
        case `default`, neutral
    }

    @Environment(\.neoBrutalismTheme) var theme: Theme

    let type: CardType
    let header: Header?
    let main: Main
    let footer: Footer?

    public init(type: CardType = .default,
                @ViewBuilder header: () -> Header? = { EmptyView() },
                @ViewBuilder main: () -> Main,
                @ViewBuilder footer: () -> Footer? = { EmptyView() }) {
        self.type = type
        self.header = header()
        self.main = main()
        self.footer = footer()
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
            VStack(alignment: .leading, spacing: theme.xlspacing) {
                header
                    .foregroundStyle(textForegroundColor)
                    .bold()
                main
                    .foregroundStyle(textForegroundColor)
                footer
                    .foregroundStyle(textForegroundColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(theme.padding)
        }
        .neoBrutalismBox()
    }
}

@available(iOS 17.0, *)
#Preview {
    VStack(spacing: 12.0) {
        Card {
            Text("Header")
        } main: {
            Text("Main")
        } footer: {
            Text("Footer")
        }

        Spacer()
    }.padding()
}
