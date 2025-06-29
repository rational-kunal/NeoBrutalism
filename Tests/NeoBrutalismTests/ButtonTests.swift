import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct NBButtonStyleTests {
    // MARK: - Default Type

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_default() -> some View {
        Button("Default") {}
            .buttonStyle(.neoBrutalism())
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_default_pressed_reverse() -> some View {
        Button("Default") {} // TODO: This should fail
            .buttonStyle(.neoBrutalism(variant: .reverse))
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_default_noShadow() -> some View {
        Button("Default No Shadow") {}
            .buttonStyle(.neoBrutalism(variant: .noShadow))
    }

    // MARK: - Neutral Type

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_neutral() -> some View {
        Button("Neutral") {}
            .buttonStyle(.neoBrutalism(type: .neutral))
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_neutral_reverse() -> some View {
        Button("Neutral Reverse") {}
            .buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_neutral_noShadow() -> some View {
        Button("Neutral No Shadow") {}
            .buttonStyle(.neoBrutalism(type: .neutral, variant: .noShadow))
    }

    // MARK: - Buttons with Label or Multiline Text

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_with_icon() -> some View {
        Button {} label: {
            Label("With Icon", systemImage: "star.fill")
        }
        .buttonStyle(.neoBrutalism())
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background))
    func button_multiline_text() -> some View {
        Button {} label: {
            Text("This is a button\nwith multiple lines")
                .multilineTextAlignment(.center)
        }
        .buttonStyle(.neoBrutalism())
    }
}
