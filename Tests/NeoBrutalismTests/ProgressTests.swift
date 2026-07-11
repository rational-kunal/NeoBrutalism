import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct ProgressTests {
    @Test func progress_0() {
        assertNBSnapshot(
            of: ProgressView(value: 0.0)
                .progressViewStyle(.neoBrutalism)
        )
    }

    @Test func progress_52() {
        assertNBSnapshot(
            of: ProgressView(value: 0.52)
                .progressViewStyle(.neoBrutalism)
        )
    }

    @Test func progress_100() {
        assertNBSnapshot(
            of: ProgressView(value: 1.0)
                .progressViewStyle(.neoBrutalism)
        )
    }

    @Test func progress_indeterminate() {
        assertNBSnapshot(
            of: ProgressView { Text("Loading...") }
                .progressViewStyle(.neoBrutalism)
        )
    }
}
