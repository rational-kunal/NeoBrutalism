import SwiftUI

private struct CheckboxShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let scale = min(rect.width, rect.height) / 16.0

        path.move(to: CGPoint(x: 4.0 * scale, y: 8 * scale))
        path.addLine(to: CGPoint(x: 7.0 * scale, y: 11.5 * scale))
        path.addLine(to: CGPoint(x: 11.5 * scale, y: 4.5 * scale))

        return path
    }
}

public struct Checkbox: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.neoBrutalismTheme) var theme: Theme

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        _isOn = isOn
    }

    public var body: some View {
        ZStack {
            // Background color
            if !isEnabled {
                theme.main.opacity(0.5)
            } else if isOn {
                theme.main
            } else {
                theme.clear
            }

            // Checkbox
            if isOn {
                CheckboxShape()
                    .stroke(theme.border, style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round))
            }
        }
        .contentShape(Rectangle())
        .frame(width: theme.size, height: theme.size)
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .opacity(isEnabled ? 1 : 0.5)
        .onTapGesture {
            if isEnabled {
                withAnimation(.interactiveSpring) {
                    isOn.toggle()
                }
            }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var checkboxState1 = true
    @Previewable @State var checkboxState2 = false

    HStack {
        VStack {
            HStack {
                Checkbox(isOn: $checkboxState1)
                Text("Checkbox")
            }
            Checkbox(isOn: $checkboxState1)
                .disabled(true)
            Checkbox(isOn: $checkboxState2)
                .disabled(true)
            Checkbox(isOn: $checkboxState2)
        }
    }
}
