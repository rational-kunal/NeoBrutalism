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

public struct NBSwitch: View {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nbTheme) var theme: NBTheme

    @Binding private var isOn: Bool

    public init(isOn: Binding<Bool>) {
        _isOn = isOn
    }

    public var body: some View {
        ZStack {
            backgroundColor
            thumbShape
        }
        .contentShape(Rectangle())
        .frame(width: 2 * theme.size, height: theme.size)
        .cornerRadius(theme.size)
        .overlay(
            RoundedRectangle(cornerRadius: theme.size)
                .stroke(.black, lineWidth: theme.borderWidth)
        )
        .opacity(isEnabled ? 1.0 : 0.5)
        .onTapGesture {
            if isEnabled {
                withAnimation(.interactiveSpring) {
                    isOn.toggle()
                }
            }
        }
    }
}

extension NBSwitch {
    private var backgroundColor: Color {
        if !isEnabled {
            theme.main.opacity(0.5)
        } else if isOn {
            theme.main
        } else {
            theme.clear
        }
    }

    private var thumbShape: some View {
        ThumbShape(position: isOn ? 1 : 0)
            .fill(theme.blank)
            .stroke(
                theme.border,
                style: StrokeStyle(lineWidth: theme.borderWidth, lineCap: .round, lineJoin: .round)
            )
            .padding(.all, 2 * theme.borderWidth)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var switchState1 = true
    @Previewable @State var switchState2 = false

    HStack {
        VStack {
            HStack {
                NBSwitch(isOn: $switchState1)
                Text("Switch")
            }
            NBSwitch(isOn: $switchState1)
                .disabled(true)
            NBSwitch(isOn: $switchState2)
                .disabled(true)
            NBSwitch(isOn: $switchState2)
        }
    }
}
