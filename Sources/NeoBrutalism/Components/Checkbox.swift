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

public struct NBCheckbox: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        _isOn = isOn
    }

    public var body: some View {
        ZStack {
            backgroundColor

            // Checkbox
            if isOn {
                checkboxShape
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

extension NBCheckbox {
    private var checkboxShape: some View {
        NBCheckboxShape()
            .stroke(theme.border, style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round))
    }

    private var backgroundColor: Color {
        if !isEnabled {
            theme.main.opacity(0.5)
        } else if isOn {
            theme.main
        } else {
            theme.clear
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var checkboxState1 = true
    @Previewable @State var checkboxState2 = false

    HStack {
        VStack {
            HStack {
                NBCheckbox(isOn: $checkboxState1)
                Text("Checkbox")
            }
            NBCheckbox(isOn: $checkboxState1)
                .disabled(true)
            NBCheckbox(isOn: $checkboxState2)
                .disabled(true)
            NBCheckbox(isOn: $checkboxState2)
        }
    }
}
