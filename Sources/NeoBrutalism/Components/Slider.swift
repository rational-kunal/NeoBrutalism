import SwiftUI

public struct NBSlider: View {
    @Environment(\.nbTheme) var theme: NBTheme

    /** Value from 0 to 1 */
    @Binding private var value: CGFloat

    public init(value: Binding<CGFloat>) {
        _value = value
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                let sliderBarWidth = geometry.size.width
                let fillWidth = max(0, min(value, 1)) * sliderBarWidth
                let thumbOffsetX = max(0, min(value, 1)) * sliderBarWidth
                let thumbOffsetY = theme.size / 4

                ZStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        // Progress bar
                        Rectangle()
                            .fill(theme.main)
                            .frame(width: fillWidth, height: theme.size)

                        // Background bar
                        Rectangle()
                            .fill(theme.bw)
                            .frame(height: theme.size)
                    }
                }
                .frame(width: sliderBarWidth, height: theme.smsize)
                .nbBox(elevated: false)
                .overlay {
                    Circle()
                        .fill(theme.blank)
                        .stroke(theme.border, lineWidth: theme.borderWidth)
                        .frame(width: theme.size, height: theme.size)
                        .position(.init(x: thumbOffsetX, y: thumbOffsetY))
                        .gesture(
                            DragGesture().onChanged { value in
                                let startLocation = value.startLocation.x / geometry.size.width
                                let translation = value.translation.width / geometry.size.width
                                self.value = max(0, min(1, startLocation + translation))
                            })
                }
                .frame(width: sliderBarWidth, height: theme.size)
            }
            .frame(height: theme.size)
            .padding(theme.size / 2)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var sliderValue: CGFloat = 0.5

    VStack {
        ZStack {
            HStack(alignment: .center) {
                Text("\(sliderValue, specifier: "%.2f")")
                    .padding(.horizontal)
                    .frame(width: 100.0)
                NBSlider(value: $sliderValue)
            }
        }
        NBSlider(value: .constant(0.52))
        NBSlider(value: .constant(0.2))
        NBSlider(value: .constant(1.0))
    }
}
