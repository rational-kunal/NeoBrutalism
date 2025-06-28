import SwiftUI

@available(*, deprecated, message: "Use DisclosureGroup with DisclosureGroupStyle.neoBrutalismAccordion instead")
public struct NBAccordion<Trigger, Content>: View where Trigger: View, Content: View {
    @Environment(\.nbTheme) var theme: NBTheme

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
                triggerWrappedView
                    .overlay(
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: theme.borderWidth)
                            .background(theme.border), alignment: .bottom
                    )
                    .onTapGesture {
                        withAnimation(.interactiveSpring) {
                            isExpanded.toggle()
                        }
                    }

                content
                    .padding(theme.padding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: isExpanded ? nil : 0.0)
                    .clipped()
                    .background(content: {
                        theme.bw
                    })
                    .foregroundStyle(theme.text)
            }
        }
        .foregroundStyle(theme.mainText)
        .nbBox()
    }
}

extension NBAccordion {
    var triggerWrappedView: some View {
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
        .fixedSize(horizontal: false, vertical: true)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack(spacing: 18.0) {
        NBAccordion {
            Text("Piertotum Locomotor")
        } content: {
            Text("Pratimo Jeevit Bhavh - प्रतिमा जीवित भाव")
        }

        NBAccordion {
            Text("Expecto Patronum")
        } content: {
            Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
        }

        DisclosureGroup("Expecto Patronum") {
            Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
        }.disclosureGroupStyle(.neoBrutalismAccordion)

    }.padding()
}
