import SwiftUI

public extension GaugeStyle where Self == NBGaugeStyle {
    static var neoBrutalism: NBGaugeStyle { .init() }
}

/// A neobrutalist gauge style that renders a horizontal bar meter.
///
/// The gauge displays a filled portion using the theme's `main` color
/// against a `bw` background, wrapped in an `.nbBox()` container.
///
/// ```swift
/// Gauge(value: 0.7) {
///     Text("Progress")
/// }
/// .gaugeStyle(.neoBrutalism)
/// ```
public struct NBGaugeStyle: GaugeStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    public func makeBody(configuration: Configuration) -> some View {
        let value = configuration.value
        HStack(spacing: theme.spacing) {
            configuration.label
            NBBarMeter(fraction: value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .nbBox(elevated: false)
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        Gauge(value: 0.0) { Text("Empty") }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 0.52) { Text("Half") }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 0.2) { Text("Low") }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 1.0) { Text("Full") }
            .gaugeStyle(.neoBrutalism)
    }
}
