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
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) {}
            .disabled(true)
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_off() -> some View {
        Toggle(isOn: .constant(false)) {}
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checbox_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) {}
            .disabled(true)
            .toggleStyle(.nbChecklist)
    }

    // MARK: - Checkbox with label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_on() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_on_disabled() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_off() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .toggleStyle(.nbChecklist)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLabel_off_disabled() -> some View {
        Toggle(isOn: .constant(false)) { Text("checkbox") }
            .disabled(true)
            .toggleStyle(.nbChecklist)
    }

    // MARK: - Checbox with large label

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background))
    func checboxWithLargeLabel() -> some View {
        Toggle(isOn: .constant(true)) { Text("checkbox").font(.largeTitle) }
            .toggleStyle(.nbChecklist)
    }
}
