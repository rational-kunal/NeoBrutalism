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

    @Test func slider_disabled() {
        assertNBSnapshot(of: NBSlider(value: .constant(0.48)).disabled(true))
    }

    @Test func slider_range_with_step() {
        assertNBSnapshot(of: NBSlider(value: .constant(50.0), in: 0...100, step: 5))
    }

    @Test func slider_range_disabled() {
        assertNBSnapshot(of: NBSlider(value: .constant(30.0), in: 0...100, step: 5).disabled(true))
    }
}
