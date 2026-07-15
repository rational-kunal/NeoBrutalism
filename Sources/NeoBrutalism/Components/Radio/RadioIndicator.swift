import SwiftUI

/// The circular selection dot used by `NBRadioItem` and `NBRadioStyle` — a themed ring
/// that fills with a solid center when `selected`.
///
/// Exposed publicly so it can be reused when building custom radio-like controls, but most
/// call sites want `NBRadioItem` or `.toggleStyle(.neoBrutalismRadio)` instead.
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
