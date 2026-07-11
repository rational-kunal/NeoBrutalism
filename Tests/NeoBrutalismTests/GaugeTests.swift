import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct GaugeTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func gauge_0() -> some View {
        Gauge(value: 0.0) { Text("Empty") }
            .gaugeStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func gauge_52() -> some View {
        Gauge(value: 0.52) { Text("Half") }
            .gaugeStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func gauge_20() -> some View {
        Gauge(value: 0.2) { Text("Low") }
            .gaugeStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func gauge_100() -> some View {
        Gauge(value: 1.0) { Text("Full") }
            .gaugeStyle(.neoBrutalism)
            .prettifyForTest()
    }
}
