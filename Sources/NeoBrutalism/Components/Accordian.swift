import SwiftUI

public struct Accordion<Trigger, Content>: View where Trigger: View, Content: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    let trigger: Trigger
    let content: Content

    @State private var isExpanded = false

    public init(@ViewBuilder trigger: () -> Trigger, @ViewBuilder content: () -> Content) {
        self.trigger = trigger()
        self.content = content()
    }

    public var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                ZStack {
                    theme.main
                    HStack {
                        trigger
                            .bold()
                            .padding(theme.padding)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .animation(.interactiveSpring, value: isExpanded)
                            .padding(.trailing, theme.padding)
                    }
                }
                .overlay(
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: theme.borderWidth)
                        .background(Color.black), alignment: .bottom
                )
                .onTapGesture {
                    withAnimation(.interactiveSpring) {
                        isExpanded.toggle()
                    }
                }
                .fixedSize(horizontal: false, vertical: true)

                if isExpanded {
                    content
                        .padding(theme.padding)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .foregroundStyle(theme.mainText)
        .neoBrutalismBox()
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    VStack(spacing: 18.0) {
        Accordion {
            Text("Piertotum Locomotor")
        } content: {
            Text("Pratimo Jeevit Bhavh - प्रतिमा जीवित भाव")
        }

        Accordion {
            Text("Expecto Patronum")
        } content: {
            Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
        }

    }.padding()
}
