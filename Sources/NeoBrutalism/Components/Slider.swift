import SwiftUI

public struct Slider: View {
    @Environment(\.neoBrutalismTheme) var theme: Theme

    /** Value from 0 to 1 */
    @Binding private var value: CGFloat

    public init(value: Binding<CGFloat>) {
        _value = value
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let sliderBarWidth = geometry.size.width - theme.size
                let fillWidth = max(0, min(value, 1)) * sliderBarWidth
                let thumbOffsetX = max(0, min(value, 1)) * (geometry.size.width - theme.size)
                let thumbOffsetY = theme.size / 4

                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        // Progress bar
                        Rectangle()
                            .fill(theme.main)
                            .frame(width: fillWidth, height: theme.size)

                        // Background bar
                        Rectangle()
                            .fill(theme.blank)
                            .frame(height: theme.size)
                    }
                }
                .frame(width: geometry.size.width - theme.size, height: theme.ssize)
                .neoBrutalismBox(elevated: false)
                .overlay {
                    Circle()
                        .fill(theme.blank)
                        .stroke(theme.border, lineWidth: theme.borderWidth)
                        .frame(width: theme.size, height: theme.size)
                        .position(.init(x: thumbOffsetX, y: thumbOffsetY))
                        .gesture(DragGesture().onChanged { value in
                            let startLocation = value.startLocation.x / geometry.size.width
                            let translation = value.translation.width / geometry.size.width
                            self.value = max(0, min(1, startLocation + translation))
                        })
                }
                .frame(width: geometry.size.width - theme.size, height: theme.size)
            }
            .frame(height: theme.size)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NeoBrutalismPreviewHelper())) {
    @Previewable @State var sliderValue: CGFloat = 0.5

    VStack {
        ZStack {
            HStack(alignment: .center) {
                Text("\(sliderValue, specifier: "%.2f")")
                    .padding(.horizontal)
                    .frame(width: 100.0)
                Slider(value: $sliderValue)
            }
        }
        Slider(value: .constant(0.52))
        Slider(value: .constant(0.2))
        Slider(value: .constant(1.0))
    }
}
