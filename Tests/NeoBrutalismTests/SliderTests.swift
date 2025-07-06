import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SliderTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func slider_0() -> some View {
        NBSlider(value: .constant(0))
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func slider_100() -> some View {
        NBSlider(value: .constant(1.0))
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func slider_48() -> some View {
        NBSlider(value: .constant(0.48))
            .prettifyForTest()
    }
}
