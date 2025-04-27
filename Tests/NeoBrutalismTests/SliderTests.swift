import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SliderTests {
    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func slider_0() -> some View {
        NB.slider(value: .constant(0))
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func slider_100() -> some View {
        NB.slider(value: .constant(1.0))
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func slider_48() -> some View {
        NB.slider(value: .constant(0.48))
    }
}
