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

        path.addEllipse(in: CGRect(
            x: circleX - diameter / 2,
            y: circleY - diameter / 2,
            width: diameter,
            height: diameter
        ))

        return path
    }
}

public struct Switch: NeoBrutalismBase, View {

    @Environment(\.isEnabled) private var isEnabled

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
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

            // Thumb
            ThumbShape(position: isOn ? 1 : 0)
                .stroke(.black, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
                .padding(.all, 2 * strokeWidth)
        }
        .contentShape(Rectangle())
        .frame(width: 2 * size, height: size)
        .cornerRadius(size)
        .overlay(
            RoundedRectangle(cornerRadius: size)
                .stroke(.black, lineWidth: strokeWidth)
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
