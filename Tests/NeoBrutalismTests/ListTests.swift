import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

/// Snapshots for the `nbList()` / `nbListRow()` helpers: the resting (non-swiped) row card
/// chrome on both a `List` and a `Form` (which is a `List` under the hood).
@Suite(.snapshots) @MainActor
struct ListTests {
    @Test func list_basic() {
        assertNBSnapshot(
            of: List {
                ForEach(0..<3, id: \.self) { index in
                    Text("Row \(index + 1)")
                        .nbListRow()
                }
            }
            .nbList()
            .frame(height: 300)
            .neoBrutalism()
        )
    }

    @Test func form_basic() {
        assertNBSnapshot(
            of: Form {
                Section("Settings") {
                    Toggle("Enable Notifications", isOn: .constant(true))
                        .nbListRow()

                    TextField("Enter text", text: .constant("Sample"))
                        .nbListRow()

                    LabeledContent("House") {
                        Text("Gryffindor")
                    }
                    .nbListRow()
                }
            }
            .nbList()
            .frame(height: 300)
            .neoBrutalism()
        )
    }
}
