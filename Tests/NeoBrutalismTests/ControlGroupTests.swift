import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct ControlGroupStyleTests {
    @Test func controlGroup_default() {
        assertNBSnapshot(
            of: ControlGroup {
                Button("Bold") {}
                Button("Italic") {}
                Button("Underline") {}
            }
            .controlGroupStyle(.neoBrutalism)
        )
    }

    @Test func controlGroup_with_icons() {
        assertNBSnapshot(
            of: ControlGroup {
                Button {} label: {
                    Label("Cut", systemImage: "scissors")
                }
                Button {} label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                Button {} label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
            }
            .controlGroupStyle(.neoBrutalism)
        )
    }
}
