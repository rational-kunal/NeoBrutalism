import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct CheckboxTests {
    // MARK: - Checkbox

    @Test func checbox_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checbox_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checbox_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checbox_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    // MARK: - Checkbox with label

    @Test func checboxWithLabel_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox") }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checboxWithLabel_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox") }
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checboxWithLabel_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("checkbox") }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checboxWithLabel_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("checkbox") }
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    // MARK: - Checbox with large label

    @Test func checboxWithLargeLabel() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox").font(.largeTitle) }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }
}
