@testable import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct RadioTests {
    // MARK: - Radio Group

    @Test func radio_singleSelection_firstSelected() {
        assertNBSnapshot(
            of: NBRadioGroup(value: .constant(0)) {
                NBRadioItem(value: 0) {
                    Text("First")
                }
                NBRadioItem(value: 1) {
                    Text("Second")
                }
            }
        )
    }

    @Test func radio_singleSelection_secondSelected() {
        assertNBSnapshot(
            of: NBRadioGroup(value: .constant(1)) {
                NBRadioItem(value: 0) {
                    Text("First")
                }
                NBRadioItem(value: 1) {
                    Text("Second")
                }
            }
        )
    }

    // MARK: - Radio Group with Label

    @Test func radio_withLabel() {
        assertNBSnapshot(
            of: NBRadioGroup(value: .constant(2)) {
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
        )
    }

    // MARK: - Radio Item Standalone

    @Test func radioItem_selected() {
        assertNBSnapshot(
            of: NBRadioItem(value: 0) {
                Text("Standalone")
            }
            .environment(\.nbSelectedRadioItemValue, 0)
        )
    }

    @Test func radioItem_unselected() {
        assertNBSnapshot(
            of: NBRadioItem(value: 1) {
                Text("Standalone")
            }
            .environment(\.nbSelectedRadioItemValue, 0)
        )
    }
}
