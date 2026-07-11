import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct LabelTests {
    @Test func label_default() {
        assertNBSnapshot(
            of: Label("Favorites", systemImage: "star.fill")
                .labelStyle(.neoBrutalism)
        )
    }

    @Test func label_with_gear_icon() {
        assertNBSnapshot(
            of: Label("Settings", systemImage: "gear")
                .labelStyle(.neoBrutalism)
        )
    }

    @Test func label_long_text() {
        assertNBSnapshot(
            of: Label("A longer label title", systemImage: "doc.text")
                .labelStyle(.neoBrutalism)
        )
    }
}
