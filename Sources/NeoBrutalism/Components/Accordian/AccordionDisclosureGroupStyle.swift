import SwiftUI

public extension DisclosureGroupStyle where Self == NBAccordionDisclosureGroupStyle {
    static var neoBrutalismAccordion: NBAccordionDisclosureGroupStyle { .init() }
}

public struct NBAccordionDisclosureGroupStyle: DisclosureGroupStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation(.interactiveSpring) {
                    configuration.isExpanded.toggle()
                }
            } label: {
                makeTriggerWrappedView(configuration: configuration)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .background(theme.bw)

            if configuration.isExpanded {
                configuration.content
                    .padding(theme.padding)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: configuration.isExpanded ? nil : 0.0)
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

    func makeTriggerWrappedView(configuration: Configuration) -> some View {
        ZStack {
            theme.main
            HStack {
                configuration.label
                    .bold()
                    .padding(theme.padding)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(configuration.isExpanded ? 180 : 0))
                    .animation(.interactiveSpring, value: configuration.isExpanded)
                    .padding(.trailing, theme.padding)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .overlay(
            Divider()
                .frame(maxWidth: .infinity, maxHeight: theme.borderWidth)
                .background(theme.border), alignment: .bottom
        )
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
