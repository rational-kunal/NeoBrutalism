import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

// TODO: Output image is not correct for switch
// https://github.com/adammcarter/swift-snapshot-testing-macros/issues/43
@Suite @SnapshotSuite @MainActor
struct SwitchTests {
    // MARK: - Switch

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switch_on() -> some View {
        Toggle(isOn: .constant(true)) {}
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switch_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) {}
            .disabled(true)
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switch_off() -> some View {
        Toggle(isOn: .constant(false)) {}
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switch_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) {}
            .disabled(true)
            .toggleStyle(.nbSwitch)
    }

    // MARK: - Switch with label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switchWithLabel_on() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch") }
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switchWithLabel_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch") }
            .disabled(true)
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switchWithLabel_off() -> some View {
        Toggle(isOn: .constant(false)) { Text("Switch") }
            .toggleStyle(.nbSwitch)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switchWithLabel_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) { Text("Switch") }
            .disabled(true)
            .toggleStyle(.nbSwitch)
    }

    // MARK: - Switch with large label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func switchWithLargeLabel() -> some View {
        Toggle(isOn: .constant(true)) { Text("Switch").font(.largeTitle) }
            .toggleStyle(.nbSwitch)
    }
}
