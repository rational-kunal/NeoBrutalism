import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct MenuStyleTests {
    @Test func menu_default() {
        assertNBSnapshot(
            of: Menu("Options") {
                Button("Edit", action: {})
                Button("Delete", action: {})
            }
            .menuStyle(.neoBrutalism)
        )
    }

    @Test func menu_with_icon() {
        assertNBSnapshot(
            of: Menu {
                Button("Cut", action: {})
                Button("Copy", action: {})
            } label: {
                Label("Actions", systemImage: "ellipsis.circle")
            }
            .menuStyle(.neoBrutalism)
        )
    }

    @Test func nbMenu_trigger() {
        assertNBSnapshot(
            of: NBMenu {
                NBMenuItem("Edit", systemImage: "pencil") {}
                NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
            } label: {
                Text("Options")
            }
        )
    }
}
