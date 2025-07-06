import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SwitchTests {
    // MARK: - Switch

    @SnapshotTest func switch_on() -> some View {
        Toggle(isOn: .constant(true)) {}
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switch_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switch_off() -> some View {
        Toggle(isOn: .constant(false)) {}
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switch_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    // MARK: - Switch with label

    @SnapshotTest func switchWithLabel_on() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch") }
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switchWithLabel_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch") }
            .disabled(true)
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switchWithLabel_off() -> some View {
        Toggle(isOn: .constant(false)) { Text("Switch") }
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    @SnapshotTest func switchWithLabel_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) { Text("Switch") }
            .disabled(true)
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }

    // MARK: - Switch with large label

    @SnapshotTest func switchWithLargeLabel() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch").font(.largeTitle) }
            .toggleStyle(.neoBrutalismSwitch)
            .prettifyForTest()
    }
}
