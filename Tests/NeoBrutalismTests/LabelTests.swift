import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct LabelTests {
    @SnapshotTest func label_default() -> some View {
        Label("Favorites", systemImage: "star.fill")
            .labelStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest func label_with_gear_icon() -> some View {
        Label("Settings", systemImage: "gear")
            .labelStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest func label_long_text() -> some View {
        Label("A longer label title", systemImage: "doc.text")
            .labelStyle(.neoBrutalism)
            .prettifyForTest()
    }
}
