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
}
