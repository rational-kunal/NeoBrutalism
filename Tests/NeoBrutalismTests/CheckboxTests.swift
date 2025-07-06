import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct CheckboxTests {
    // MARK: - Checkbox

    @SnapshotTest func checbox_on() -> some View {
        Toggle(isOn: .constant(true)) {}
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checbox_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checbox_off() -> some View {
        Toggle(isOn: .constant(false)) {}
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checbox_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    // MARK: - Checkbox with label

    @SnapshotTest func checboxWithLabel_on() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checboxWithLabel_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checboxWithLabel_off() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    @SnapshotTest func checboxWithLabel_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }

    // MARK: - Checbox with large label

    @SnapshotTest func checboxWithLargeLabel() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox").font(.largeTitle) }
            .toggleStyle(.neoBrutalismChecklist)
            .prettifyForTest()
    }
}
