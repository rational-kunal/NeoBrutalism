import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct InputTests {
    // MARK: - Input (TextField)

    @Test func input_enabled() {
        assertNBSnapshot(
            of: TextField("Input", text: .constant("Enabled"))
                .textFieldStyle(.neoBrutalism)
        )
    }

    @Test func input_disabled() {
        assertNBSnapshot(
            of: TextField("Input", text: .constant("Disabled"))
                .disabled(true)
                .textFieldStyle(.neoBrutalism)
        )
    }

    @Test func input_empty() {
        assertNBSnapshot(
            of: TextField("Placeholder", text: .constant(""))
                .textFieldStyle(.neoBrutalism)
        )
    }

    @Test func input_filled() {
        assertNBSnapshot(
            of: TextField("Input", text: .constant("Filled input text"))
                .textFieldStyle(.neoBrutalism)
        )
    }

    @Test func input_long_text() {
        assertNBSnapshot(
            of: TextField("Input", text: .constant("This is a very very very long input text that should overflow or wrap accordingly."))
                .textFieldStyle(.neoBrutalism)
        )
    }
}
