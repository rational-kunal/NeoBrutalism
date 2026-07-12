import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct NavigationTests {
    @Test func navigation_bar() {
        assertNBSnapshot(
            of: NavigationStack {
                Text("Content")
                    .navigationTitle("Navigation Title")
                    .nbNavigationBar()
            }
        )
    }
}
