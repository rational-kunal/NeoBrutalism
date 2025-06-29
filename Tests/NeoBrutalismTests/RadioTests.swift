@testable import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite(.record) @MainActor
struct RadioTests {
    // MARK: - Radio Group

    @SnapshotTest(.padding(4.0), .sizes(.minimum), .backgroundColor(NBTheme.default.background))
    func radio_singleSelection_firstSelected() -> some View {
        return NBRadioGroup(value: .constant(0)) {
            NBRadioItem(value: 0) {
                Text("First")
            }
            NBRadioItem(value: 1) {
                Text("Second")
            }
        }
        .fixedSize()
        .background(Color.orange)
    }

    @SnapshotTest(.padding(4.0), .sizes(.minimum), .backgroundColor(NBTheme.default.background))
    func radio_singleSelection_secondSelected() -> some View {
        return NBRadioGroup(value: .constant(1)) {
            NBRadioItem(value: 0) {
                Text("First")
            }
            NBRadioItem(value: 1) {
                Text("Second")
            }
        }
        .fixedSize()
        .background(Color.orange)
    }

    // MARK: - Radio Group with Label

    @SnapshotTest(.padding(4.0), .sizes(.minimum), .backgroundColor(NBTheme.default.background))
    func radio_withLabel() -> some View {
        return NBRadioGroup(value: .constant(2)) {
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
        .fixedSize()
        .background(Color.orange)
    }

    // MARK: - Radio Item Standalone

    @SnapshotTest(.padding(4.0), .sizes(.minimum), .backgroundColor(NBTheme.default.background))
    func radioItem_selected() -> some View {
        NBRadioItem(value: 0) {
            Text("Standalone")
        }
        .fixedSize()
        .environment(\.nbSelectedRadioItemValue, 0)
        .background(Color.orange)
    }

    @SnapshotTest(.padding(4.0), .sizes(.minimum), .backgroundColor(NBTheme.default.background))
    func radioItem_unselected() -> some View {
        NBRadioItem(value: 1) {
            Text("Standalone")
        }
        .fixedSize()
        .environment(\.nbSelectedRadioItemValue, 0)
        .background(Color.orange)
    }
}
