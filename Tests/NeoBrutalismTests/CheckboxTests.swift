import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct CheckboxTests {
    // MARK: - Checkbox

    @Test func checkbox_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkbox_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkbox_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkbox_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    // MARK: - Checkbox with label

    @Test func checkboxWithLabel_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox") }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkboxWithLabel_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox") }
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkboxWithLabel_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("checkbox") }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    @Test func checkboxWithLabel_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("checkbox") }
                .disabled(true)
                .toggleStyle(.neoBrutalismChecklist)
        )
    }

    // MARK: - Checkbox with large label

    @Test func checkboxWithLargeLabel() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("checkbox").font(.largeTitle) }
                .toggleStyle(.neoBrutalismChecklist)
        )
    }
}
