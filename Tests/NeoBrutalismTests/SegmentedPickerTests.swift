import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SegmentedPickerTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func segmentedPicker_firstSelected() -> some View {
        NBSegmentedPicker(selection: .constant("One")) {
            Text("One").nbSegment("One")
            Text("Two").nbSegment("Two")
            Text("Three").nbSegment("Three")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func segmentedPicker_middleSelected() -> some View {
        NBSegmentedPicker(selection: .constant("Two")) {
            Text("One").nbSegment("One")
            Text("Two").nbSegment("Two")
            Text("Three").nbSegment("Three")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func segmentedPicker_lastSelected() -> some View {
        NBSegmentedPicker(selection: .constant("Three")) {
            Text("One").nbSegment("One")
            Text("Two").nbSegment("Two")
            Text("Three").nbSegment("Three")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func segmentedPicker_intValues() -> some View {
        NBSegmentedPicker(selection: .constant(1)) {
            Text("S").nbSegment(0)
            Text("M").nbSegment(1)
            Text("L").nbSegment(2)
        }
        .prettifyForTest()
    }
}
