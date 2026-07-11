import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct SegmentedPickerTests {
    @Test func segmentedPicker_firstSelected() {
        assertNBSnapshot(
            of: NBSegmentedPicker(selection: .constant("One")) {
                Text("One").nbSegment("One")
                Text("Two").nbSegment("Two")
                Text("Three").nbSegment("Three")
            }
        )
    }

    @Test func segmentedPicker_middleSelected() {
        assertNBSnapshot(
            of: NBSegmentedPicker(selection: .constant("Two")) {
                Text("One").nbSegment("One")
                Text("Two").nbSegment("Two")
                Text("Three").nbSegment("Three")
            }
        )
    }

    @Test func segmentedPicker_lastSelected() {
        assertNBSnapshot(
            of: NBSegmentedPicker(selection: .constant("Three")) {
                Text("One").nbSegment("One")
                Text("Two").nbSegment("Two")
                Text("Three").nbSegment("Three")
            }
        )
    }

    @Test func segmentedPicker_intValues() {
        assertNBSnapshot(
            of: NBSegmentedPicker(selection: .constant(1)) {
                Text("S").nbSegment(0)
                Text("M").nbSegment(1)
                Text("L").nbSegment(2)
            }
        )
    }
}
