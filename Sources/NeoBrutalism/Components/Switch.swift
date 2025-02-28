import SwiftUI

struct ThumbShape: Shape {
    // 0 for left, 1 for right
    var position: CGFloat

    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let diameter = rect.height
        let circleX = rect.minX + (rect.width - diameter) * position + diameter / 2
        let circleY = rect.midY

        path.addEllipse(
            in: CGRect(
                x: circleX - diameter / 2,
                y: circleY - diameter / 2,
                width: diameter,
                height: diameter
            ))

        return path
    }
}

public struct Switch: View {
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

            // Thumb
            ThumbShape(position: isOn ? 1 : 0)
                .fill(theme.blank)
                .stroke(
                    theme.border,
                    style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round)
                )
                .padding(.all, 2 * theme.borderWidth)
        }
        .contentShape(Rectangle())
        .frame(width: 2 * theme.size, height: theme.size)
        .cornerRadius(theme.size)
        .overlay(
            RoundedRectangle(cornerRadius: theme.size)
                .stroke(.black, lineWidth: theme.borderWidth)
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

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var switchState1 = true
    @Previewable @State var switchState2 = false

    HStack {
        VStack {
            HStack {
                Switch(isOn: $switchState1)
                Text("Switch")
            }
            Switch(isOn: $switchState1)
                .disabled(true)
            Switch(isOn: $switchState2)
                .disabled(true)
            Switch(isOn: $switchState2)
        }
    }
}
