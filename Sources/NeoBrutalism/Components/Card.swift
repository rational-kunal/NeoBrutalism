import SwiftUI

public struct NBCard<Header, Main, Footer>: View where Header: View, Main: View, Footer: View {
    public enum CardType {
        case `default`, neutral
    }

    @Environment(\.nbTheme) var theme: NBTheme

    let type: CardType
    let header: Header?
    let main: Main
    let footer: Footer?

    public init(
        type: CardType = .default,
        @ViewBuilder header: () -> Header? = { EmptyView() },
        @ViewBuilder main: () -> Main,
        @ViewBuilder footer: () -> Footer? = { EmptyView() }
    ) {
        self.type = type
        self.header = header()
        self.main = main()
        self.footer = footer()
    }

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: theme.spacing) {
                header
                    .foregroundStyle(textForegroundColor)
                    .bold()

                main
                    .foregroundStyle(textForegroundColor)

                footer
                    .foregroundStyle(textForegroundColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(theme.xlpadding)
            .background(backgroundColor)
        }
        .nbBox()
    }
}

extension NBCard {
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
        NBCard {
            Text("Header")
        } main: {
            Text("Main")
        } footer: {
            Text("Footer")
        }

        NBCard(type: .neutral) {
            Text("Header")
        } main: {
            Text("Main")
        } footer: {
            Text("Footer")
        }
    }
}
