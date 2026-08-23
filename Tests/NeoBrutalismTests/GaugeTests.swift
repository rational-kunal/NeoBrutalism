import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct GaugeTests {
    @Test func gauge_0() {
        assertNBSnapshot(
            of: Gauge(value: 0.0) { Text("Empty") }
                .gaugeStyle(.neoBrutalism)
        )
    }

    @Test func gauge_52() {
        assertNBSnapshot(
            of: Gauge(value: 0.52) { Text("Half") }
                .gaugeStyle(.neoBrutalism)
        )
    }

    @Test func gauge_100() {
        assertNBSnapshot(
            of: Gauge(value: 1.0) { Text("Full") }
                .gaugeStyle(.neoBrutalism)
        )
    }

    @Test func gauge_valueLabels() {
        assertNBSnapshot(of: valueLabeledGauge)
    }

    @Test func gauge_valueLabels_narrow() {
        assertNBSnapshot(of: valueLabeledGauge, width: 180)
    }

    private var valueLabeledGauge: some View {
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
    }
}
