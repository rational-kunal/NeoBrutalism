import SwiftUI

public struct NBProgress: View {
    @Environment(\.nbTheme) var theme: NBTheme

    /** Value from 0 to 1 */
    @Binding private var value: CGFloat

    public init(value: Binding<CGFloat>) {
        _value = value
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                HStack(spacing: 0) {
                    // Progress bar
                    Rectangle()
                        .fill(theme.main)
                        .frame(width: max(0, min(value, 1)) * geometry.size.width, height: theme.size)

                    if value > 0.001 && value < 0.99 {
                        Divider()
                            .frame(width: theme.borderWidth, height: geometry.size.height)
                            .background(Color.black)
                    }

                    // Background bar
                    Rectangle()
                        .fill(theme.bw)
                        .frame(height: theme.size)
                }
            }
        }
        .frame(height: theme.size)
        .frame(maxWidth: .infinity, alignment: .leading)
        .nbBox(elevated: false)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        NBProgress(value: .constant(0.0))
        NBProgress(value: .constant(0.52))
        NBProgress(value: .constant(0.2))
        NBProgress(value: .constant(1.0))
    }
}
