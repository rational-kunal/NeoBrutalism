@testable import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct DialogTests {
    @Test func dialog_card() {
        assertNBSnapshot(
            of: NBDialogCard(
                title: "Delete spell?",
                message: AnyView(Text("This cannot be undone.")),
                actions: AnyView(
                    VStack {
                        Button("Delete", role: .destructive) {}
                        Button("Keep") {}
                    }
                )
            )
        )
    }
}
