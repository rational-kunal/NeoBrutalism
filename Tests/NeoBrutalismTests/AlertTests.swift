import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct AlertTests {
    @Test func alert_default() {
        assertNBSnapshot(
            of: NBAlert {
                Text("Something happened that you should know about.")
            } icon: {
                Image(systemName: "exclamationmark.triangle.fill")
            } head: {
                Text("Heads up")
            }
        )
    }

    @Test func alert_neutral() {
        assertNBSnapshot(
            of: NBAlert(type: .neutral) {
                Text("Something happened that you should know about.")
            } head: {
                Text("Heads up")
            }
        )
    }
}
