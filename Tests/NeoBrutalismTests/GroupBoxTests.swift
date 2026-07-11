import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct GroupBoxTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_default() -> some View {
        GroupBox("Hogwarts Letter") {
            Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")
        }
        .groupBoxStyle(.neoBrutalism())
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_neutral() -> some View {
        GroupBox("Quidditch Gear") {
            Text("Get your broomstick, Quidditch robes, and golden snitch!")
        }
        .groupBoxStyle(.neoBrutalism(type: .neutral))
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_flat() -> some View {
        GroupBox {
            Text("Flat card with no label")
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_flat_neutral() -> some View {
        GroupBox("Marauder's Map") {
            Text("I solemnly swear that I am up to no good.")
        }
        .groupBoxStyle(.neoBrutalism(type: .neutral, elevated: false))
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_no_label() -> some View {
        GroupBox {
            Text("Card with only main content")
        }
        .groupBoxStyle(.neoBrutalism())
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_long_content() -> some View {
        GroupBox("Header") {
            Text("This is a long body of content intended to test how the card handles overflowing text and wrapping within a fixed width layout.")
        }
        .groupBoxStyle(.neoBrutalism())
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func groupBox_with_icon_in_label() -> some View {
        GroupBox {
            Text("You have 3 new messages.")
        } label: {
            HStack {
                Image(systemName: "bell.fill")
                Text("Notifications")
            }
        }
        .groupBoxStyle(.neoBrutalism())
        .prettifyForTest()
    }
}
