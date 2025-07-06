@testable import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct RadioTests {
    // MARK: - Radio Group

    @SnapshotTest func radio_singleSelection_firstSelected() -> some View {
        NBRadioGroup(value: .constant(0)) {
            NBRadioItem(value: 0) {
                Text("First")
            }
            NBRadioItem(value: 1) {
                Text("Second")
            }
        }
        .prettifyForTest()
    }

    @SnapshotTest func radio_singleSelection_secondSelected() -> some View {
        NBRadioGroup(value: .constant(1)) {
            NBRadioItem(value: 0) {
                Text("First")
            }
            NBRadioItem(value: 1) {
                Text("Second")
            }
        }
        .prettifyForTest()
    }

    // MARK: - Radio Group with Label

    @SnapshotTest func radio_withLabel() -> some View {
        NBRadioGroup(value: .constant(2)) {
            Text("Choose an option")
                .font(.title2)
            NBRadioItem(value: 0) {
                Text("Option A")
            }
            NBRadioItem(value: 1) {
                Text("Option B")
            }
            NBRadioItem(value: 2) {
                Text("Option C")
            }
        }
        .prettifyForTest()
    }

    // MARK: - Radio Item Standalone

    @SnapshotTest func radioItem_selected() -> some View {
        NBRadioItem(value: 0) {
            Text("Standalone")
        }
        .environment(\.nbSelectedRadioItemValue, 0)
        .prettifyForTest()
    }

    @SnapshotTest func radioItem_unselected() -> some View {
        NBRadioItem(value: 1) {
            Text("Standalone")
        }
        .environment(\.nbSelectedRadioItemValue, 0)
        .prettifyForTest()
    }
}
