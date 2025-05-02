import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct CheckboxTests {
    // MARK: - Checkbox

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_on() -> some View {
        Toggle(isOn: .constant(true)) {}
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_off() -> some View {
        Toggle(isOn: .constant(false)) {}
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) {}
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
    }

    // MARK: - Checkbox with label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_on() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_off() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .toggleStyle(.neoBrutalismChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.neoBrutalismChecklist)
    }

    // MARK: - Checbox with large label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLargeLabel() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox").font(.largeTitle) }
            .toggleStyle(.neoBrutalismChecklist)
    }
}
