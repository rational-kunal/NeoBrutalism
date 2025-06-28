import SwiftUI

public extension ToggleStyle where Self == NBRadioStyle {
    static var neoBrutalismRadio: NBRadioStyle { .init() }
}

// TODO: https://github.com/rational-kunal/NeoBrutalism/issues/9
public struct NBRadioStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                makeRadio(configuration: configuration)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

extension NBRadioStyle {
    private func makeRadio(configuration: Configuration) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack(spacing: theme.smspacing) {
                NBRadioIndicator(selected: configuration.isOn)
            }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var value = 0
    VStack(spacing: 24.0) {
        NBRadioItem(value: 0) {
            Text("Radio Item")
        }

        Toggle(isOn: .constant(false)) {
            Text("Radio Item")
        }.toggleStyle(.neoBrutalismRadio)

        Toggle(isOn: .constant(true)) {
            Text("Radio Item")
        }.toggleStyle(.neoBrutalismRadio)
    }
}
