import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct SliderTests {
    @Test func slider_0() {
        assertNBSnapshot(of: NBSlider(value: .constant(0)))
    }

    @Test func slider_100() {
        assertNBSnapshot(of: NBSlider(value: .constant(1.0)))
    }

    @Test func slider_48() {
        assertNBSnapshot(of: NBSlider(value: .constant(0.48)))
    }
}
