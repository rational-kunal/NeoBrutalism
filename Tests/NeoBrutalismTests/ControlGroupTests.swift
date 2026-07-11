import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@MainActor @Suite @SnapshotSuite
struct ControlGroupStyleTests {
    @SnapshotTest func controlGroup_default() -> some View {
        ControlGroup {
            Button("Bold") {}
            Button("Italic") {}
            Button("Underline") {}
        }
        .controlGroupStyle(.neoBrutalism)
        .prettifyForTest()
    }

    @SnapshotTest func controlGroup_with_icons() -> some View {
        ControlGroup {
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
        .prettifyForTest()
    }
}
