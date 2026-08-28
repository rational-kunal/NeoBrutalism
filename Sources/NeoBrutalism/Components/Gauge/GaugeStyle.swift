import SwiftUI

public extension GaugeStyle where Self == NBGaugeStyle {
    /// A neobrutalist gauge style with a themed horizontal bar and support for
    /// the gauge's current, minimum, and maximum value labels.
    static var neoBrutalism: NBGaugeStyle { .init() }
}

/// A neobrutalist gauge style that renders a horizontal bar meter.
///
/// The gauge displays a filled portion using the theme's `main` color
/// against a `bw` background, wrapped in an `.nbBox()` container. When supplied,
/// the current, minimum, and maximum value labels are arranged around the bar and
/// adapt to compact widths without changing label-only gauges.
///
/// ```swift
/// Gauge(value: 70, in: 0...100) {
///     Text("Progress")
/// } currentValueLabel: {
///     Text("70%")
/// } minimumValueLabel: {
///     Text("0%")
/// } maximumValueLabel: {
///     Text("100%")
/// }
/// .gaugeStyle(.neoBrutalism)
/// ```
public struct NBGaugeStyle: GaugeStyle {
    @Environment(\.nbTheme) var theme: NBTheme

    @ViewBuilder
    public func makeBody(configuration: Configuration) -> some View {
        if hasValueLabels(configuration) {
            ViewThatFits(in: .horizontal) {
                HStack(spacing: theme.spacing) {
                    configuration.label
                        .fixedSize(horizontal: true, vertical: false)

                    labeledMeter(configuration)
                        .frame(minWidth: theme.size * 8, maxWidth: .infinity)
                }

                VStack(alignment: .leading, spacing: theme.smspacing) {
                    configuration.label
                    labeledMeter(configuration)
                }
            }
        } else {
            HStack(spacing: theme.spacing) {
                configuration.label
                meter(configuration.value)
            }
        }
    }

    private func hasValueLabels(_ configuration: Configuration) -> Bool {
        configuration.currentValueLabel != nil ||
            configuration.minimumValueLabel != nil ||
            configuration.maximumValueLabel != nil
    }

    private func labeledMeter(_ configuration: Configuration) -> some View {
        VStack(spacing: theme.smspacing) {
            valueLabels(configuration)
            meter(configuration.value)
        }
    }

    private func valueLabels(_ configuration: Configuration) -> some View {
        HStack(spacing: theme.smspacing) {
            if let minimumValueLabel = configuration.minimumValueLabel {
                minimumValueLabel
            }

            Spacer(minLength: 0)

            if let currentValueLabel = configuration.currentValueLabel {
                currentValueLabel
            }

            Spacer(minLength: 0)

            if let maximumValueLabel = configuration.maximumValueLabel {
                maximumValueLabel
            }
        }
    }

    private func meter(_ value: Double) -> some View {
        NBBarMeter(fraction: value)
            .frame(maxWidth: .infinity, alignment: .leading)
            .nbBox(elevated: false)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    VStack {
        Gauge(value: 0.0) { Text("Empty") }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 0.52) { Text("Half") }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 72, in: 0...100) {
            Text("Temperature")
        } currentValueLabel: {
            Text("72°")
        } minimumValueLabel: {
            Text("0°")
        } maximumValueLabel: {
            Text("100°")
        }
            .gaugeStyle(.neoBrutalism)

        Gauge(value: 1.0) { Text("Full") }
            .gaugeStyle(.neoBrutalism)
    }
}
