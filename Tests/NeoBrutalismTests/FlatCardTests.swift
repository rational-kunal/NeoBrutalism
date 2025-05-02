import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct FlatCardTests {
    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func flatCard_default() -> some View {
        NBFlatCard {
            Text("Default Card")
        }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func flatCard_neutral() -> some View {
        NBFlatCard(type: .neutral) {
            Text("Neutral Card")
        }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func flatCard_multiline() -> some View {
        NBFlatCard {
            VStack(alignment: .leading, spacing: 4) {
                Text("Multiline card")
                Text("With more text below")
                    .font(.footnote)
            }
        }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func flatCard_with_icon() -> some View {
        NBFlatCard {
            HStack {
                Image(systemName: "star.fill")
                Text("Card with icon")
            }
        }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func flatCard_longText() -> some View {
        NBFlatCard {
            Text("This is a very long sentence that should wrap and show how the flat card behaves with overflow or long paragraphs in its content.")
                .font(.body)
        }
    }
}
