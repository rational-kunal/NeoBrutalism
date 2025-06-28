import SwiftUI

public struct NBRadioIndicator: View {
    @Environment(\.nbTheme) var theme: NBTheme

    let selected: Bool

    public var body: some View {
        ZStack {
            Circle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
                .frame(width: theme.size, height: theme.size)

            if selected {
                let innerCircleSize = theme.size - 4 * theme.borderWidth

                Circle()
                    .fill(theme.text)
                    .frame(width: innerCircleSize, height: innerCircleSize)
            }
        }
    }
}
