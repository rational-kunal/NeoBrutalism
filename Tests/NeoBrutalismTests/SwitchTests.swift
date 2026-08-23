import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct SwitchTests {
    // MARK: - Switch

    @Test func switch_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switch_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switch_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switch_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) {}
                .disabled(true)
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    // MARK: - Switch with label

    @Test func switchWithLabel_on() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("Switch") }
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switchWithLabel_on_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("Switch") }
                .disabled(true)
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switchWithLabel_off() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("Switch") }
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    @Test func switchWithLabel_off_disabled() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(false)) { Text("Switch") }
                .disabled(true)
                .toggleStyle(.neoBrutalismSwitch)
        )
    }

    // MARK: - Switch with large label

    @Test func switchWithLargeLabel() {
        assertNBSnapshot(
            of: Toggle(isOn: .constant(true)) { Text("Switch").font(.largeTitle) }
                .toggleStyle(.neoBrutalismSwitch)
        )
    }
}
