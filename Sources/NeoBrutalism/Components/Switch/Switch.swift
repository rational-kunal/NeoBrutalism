import SwiftUI

public extension ToggleStyle where Self == NBSwitchToggleStyle {
    static var neoBrutalismSwitch: NBSwitchToggleStyle { .init() }
}

public struct NBSwitchToggleStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                makeSwitch(configuration: configuration)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

extension NBSwitchToggleStyle {
    private func makeSwitch(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: theme.size)
                .fill(configuration.isOn ? theme.main : theme.clear)
                .padding(theme.borderWidth / 2)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.size, style: .circular)
                        .stroke(.black, lineWidth: theme.borderWidth)
                )

            makeSwitchShape(configuration: configuration)
        }
        .frame(width: 2 * theme.size, height: theme.size)
    }

    private func makeSwitchShape(configuration: Configuration) -> some View {
        HStack {
            Circle()
                .fill(theme.blank)
                .padding(theme.borderWidth)
                .padding(-1 * theme.borderWidth / 2)
                .overlay(
                    Circle()
                        .stroke(.black, lineWidth: theme.borderWidth)
                )
                .padding(theme.borderWidth * 2)
                .frame(maxWidth: .infinity, alignment: configuration.isOn ? .trailing : .leading)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var switchState1 = true
    @Previewable @State var switchState2 = false

    VStack {
        HStack {
            Toggle(isOn: $switchState1) {
                Text("Switch")
            }
        }

        Toggle(isOn: $switchState1) {}
            .disabled(true)

        Toggle(isOn: $switchState2) {}
            .disabled(true)

        Toggle(isOn: $switchState2) {}

    }.toggleStyle(.neoBrutalismSwitch)
}
