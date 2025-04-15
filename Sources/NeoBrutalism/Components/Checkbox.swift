import SwiftUI

private struct NBCheckboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let scale = min(rect.width, rect.height) / 16.0

        path.move(to: CGPoint(x: 4.0 * scale, y: 8 * scale))
        path.addLine(to: CGPoint(x: 7.0 * scale, y: 11.5 * scale))
        path.addLine(to: CGPoint(x: 11.5 * scale, y: 4.5 * scale))

        return path
    }
}

struct NBCheckboxToggleStyle: ToggleStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            makeCheckbox(configuration: configuration)
            configuration.label
        }
    }

    func makeCheckbox(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            ZStack {
                if configuration.isOn {
                    theme.main
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
        }
        .buttonStyle(.plain)
        .frame(width: theme.size, height: theme.size)
    }
}

extension NBCheckboxToggleStyle {
    private var checkboxShape: some View {
        NBCheckboxShape()
            .stroke(theme.border, style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round))
    }
}

extension ToggleStyle where Self == NBCheckboxToggleStyle {
    static var nbChecklist: NBCheckboxToggleStyle { .init() }
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
    }.toggleStyle(.nbChecklist)
}
