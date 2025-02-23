import SwiftUI

public struct Card<Header, Main, Footer>: NeoBrutalismBase, View where Header: View, Main: View, Footer: View {
    let header: Header?
    let main: Main
    let footer: Footer?

    var spacing: CGFloat { 24.0 }

    public init(@ViewBuilder header: () -> Header? = { EmptyView() },
                @ViewBuilder main: () -> Main,
                @ViewBuilder footer: () -> Footer? = { EmptyView() }) {
        self.header = header()
        self.main = main()
        self.footer = footer()
    }

    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: spacing) {
                header
                    .foregroundStyle(Theme.standard.text)
                    .bold()
                main
                    .foregroundStyle(Theme.standard.text)
                footer
                    .foregroundStyle(Theme.standard.text)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(padding)
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
