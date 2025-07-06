import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct InputTests {
    // MARK: - Input (TextField)

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func input_enabled() -> some View {
        TextField("Input", text: .constant("Enabled"))
            .textFieldStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func input_disabled() -> some View {
        TextField("Input", text: .constant("Disabled"))
            .disabled(true)
            .textFieldStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func input_empty() -> some View {
        TextField("Placeholder", text: .constant(""))
            .textFieldStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func input_filled() -> some View {
        TextField("Input", text: .constant("Filled input text"))
            .textFieldStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func input_long_text() -> some View {
        TextField("Input", text: .constant("This is a very very very long input text that should overflow or wrap accordingly."))
            .textFieldStyle(.neoBrutalism)
            .prettifyForTest()
    }
}
