import SwiftUI

struct NBBarMeter: View {
    @Environment(\.nbTheme) private var theme

    let fraction: Double

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(theme.main)
                    .frame(width: fraction * geometry.size.width, height: theme.size)

                if fraction > 0.001 && fraction < 0.99 {
                    Rectangle()
                        .fill(theme.border)
                        .frame(width: theme.borderWidth, height: geometry.size.height)
                }

                Rectangle()
                    .fill(theme.bw)
                    .frame(height: theme.size)
            }
        }
        .frame(height: theme.size)
    }
}
