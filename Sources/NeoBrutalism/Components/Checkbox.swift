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

public struct Checkbox: NeoBrutalismBase, View {
    @Environment(\.isEnabled) private var isEnabled

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        _isOn = isOn
    }

    public var body: some View {
        ZStack {
            // Background color
            if !isEnabled {
                Theme.standard.main.disabled
            } else if isOn {
                Theme.standard.main
            } else {
                Theme.standard.clear
            }

            // Checkbox
            if isOn {
                CheckboxShape()
                    .stroke(Theme.standard.border, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
            }
        }
        .contentShape(Rectangle())
        .frame(width: size, height: size)
        .overlay(
            Rectangle()
                .stroke(Theme.standard.border, lineWidth: strokeWidth)
        )
        .onTapGesture {
            if isEnabled {
                withAnimation(.interactiveSpring) {
                    isOn.toggle()
                }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
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
