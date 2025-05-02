import SwiftUI

public extension ToggleStyle where Self == NBCheckboxToggleStyle {
    static var neoBrutalismChecklist: NBCheckboxToggleStyle { .init() }
}

public struct NBCheckboxToggleStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation(.interactiveSpring) {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                makeCheckbox(configuration: configuration)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

extension NBCheckboxToggleStyle {
    private func makeCheckbox(configuration: Configuration) -> some View {
        ZStack {
            if configuration.isOn {
                theme.main
                    .padding(theme.borderWidth / 2) // Border to get the space it needs
            } else {
                theme.clear
            }

            // Checkbox
            if configuration.isOn {
                checkboxShape
            }
        }
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .frame(width: theme.size, height: theme.size)
    }

    private var checkboxShape: some View {
        NBCheckboxShape()
            .stroke(theme.border, style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round))
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var checkboxState1 = true
    @Previewable @State var checkboxState2 = false

    VStack {
        HStack {
            Toggle(isOn: $checkboxState1) {
                Text("Checkbox")
            }
        }

        Toggle(isOn: $checkboxState1) {}
            .disabled(true)

        Toggle(isOn: $checkboxState2) {}
            .disabled(true)

        Toggle(isOn: $checkboxState2) {}
    }.toggleStyle(.neoBrutalismChecklist)
}
