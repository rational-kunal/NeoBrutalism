import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@MainActor @Suite @SnapshotSuite
struct MenuStyleTests {
    @SnapshotTest func menu_default() -> some View {
        Menu("Options") {
            Button("Edit", action: {})
            Button("Delete", action: {})
        }
        .menuStyle(.neoBrutalism)
        .prettifyForTest()
    }

    @SnapshotTest func menu_with_icon() -> some View {
        Menu {
            Button("Cut", action: {})
            Button("Copy", action: {})
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
        .menuStyle(.neoBrutalism)
        .prettifyForTest()
    }

    @SnapshotTest func nbMenu_trigger() -> some View {
        NBMenu {
            NBMenuItem("Edit", systemImage: "pencil") {}
            NBMenuItem("Delete", systemImage: "trash", role: .destructive) {}
        } label: {
            Text("Options")
        }
        .prettifyForTest()
    }
}
