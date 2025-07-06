import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct CardTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_default_full() -> some View {
        NBCard {
            Text("Default Header")
        } main: {
            Text("Main content goes here.")
        } footer: {
            Text("Footer information.")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_neutral_full() -> some View {
        NBCard(type: .neutral) {
            Text("Neutral Header")
        } main: {
            Text("This is the main body of a neutral card.")
        } footer: {
            Text("Footer")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_only_main() -> some View {
        NBCard {
            Text("Card with only main content")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_with_long_content() -> some View {
        NBCard {
            Text("Header")
        } main: {
            Text("This is a long body of content intended to test how the card handles overflowing text and wrapping within a fixed width layout.")
        } footer: {
            Text("Footer")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_with_icon_in_header() -> some View {
        NBCard {
            HStack {
                Image(systemName: "bell.fill")
                Text("Notifications")
            }
        } main: {
            Text("You have 3 new messages.")
        } footer: {
            Text("Last updated: just now")
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func card_header_and_main_only() -> some View {
        NBCard {
            Text("Header only")
        } main: {
            Text("Body content with no footer")
        }
        .prettifyForTest()
    }
}
