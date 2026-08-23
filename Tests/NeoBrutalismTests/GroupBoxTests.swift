import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct GroupBoxTests {
    @Test func groupBox_default() {
        assertNBSnapshot(
            of: GroupBox("Hogwarts Letter") {
                Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")
            }
            .groupBoxStyle(.neoBrutalism())
        )
    }

    @Test func groupBox_neutral() {
        assertNBSnapshot(
            of: GroupBox("Quidditch Gear") {
                Text("Get your broomstick, Quidditch robes, and golden snitch!")
            }
            .groupBoxStyle(.neoBrutalism(type: .neutral))
        )
    }

    @Test func groupBox_flat() {
        assertNBSnapshot(
            of: GroupBox {
                Text("Flat card with no label")
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
        )
    }

    @Test func groupBox_flat_neutral() {
        assertNBSnapshot(
            of: GroupBox("Marauder's Map") {
                Text("I solemnly swear that I am up to no good.")
            }
            .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
        )
    }

    @Test func groupBox_no_label() {
        assertNBSnapshot(
            of: GroupBox {
                Text("Card with only main content")
            }
            .groupBoxStyle(.neoBrutalism())
        )
    }

    @Test func groupBox_long_content() {
        assertNBSnapshot(
            of: GroupBox("Header") {
                Text("This is a long body of content intended to test how the card handles overflowing text and wrapping within a fixed width layout.")
            }
            .groupBoxStyle(.neoBrutalism())
        )
    }

    @Test func groupBox_with_icon_in_label() {
        assertNBSnapshot(
            of: GroupBox {
                Text("You have 3 new messages.")
            } label: {
                HStack {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
            }
            .groupBoxStyle(.neoBrutalism())
        )
    }
}
