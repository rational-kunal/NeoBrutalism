import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct BadgeTests {
    @Test func badge_default() {
        assertNBSnapshot(
            of: NBBadge {
                Text("New")
            }
        )
    }

    @Test func badge_neutral() {
        assertNBSnapshot(
            of: NBBadge(type: .neutral) {
                Text("New")
            }
        )
    }
}
