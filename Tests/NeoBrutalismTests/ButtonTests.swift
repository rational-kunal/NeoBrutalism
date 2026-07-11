import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct ButtonStyleTests {
    // MARK: - Default Type

    @Test func button_default() {
        assertNBSnapshot(
            of: Button("Default") {}
                .buttonStyle(.neoBrutalism())
        )
    }

    @Test func button_default_pressed_reverse() {
        assertNBSnapshot(
            of: Button("Default Reverse") {}
                .buttonStyle(.neoBrutalism(variant: .reverse))
        )
    }

    @Test func button_default_noShadow() {
        assertNBSnapshot(
            of: Button("Default No Shadow") {}
                .buttonStyle(.neoBrutalism(variant: .noShadow))
        )
    }

    // MARK: - Neutral Type

    @Test func button_neutral() {
        assertNBSnapshot(
            of: Button("Neutral") {}
                .buttonStyle(.neoBrutalism(type: .neutral))
        )
    }

    @Test func button_neutral_reverse() {
        assertNBSnapshot(
            of: Button("Neutral Reverse") {}
                .buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
        )
    }

    @Test func button_neutral_noShadow() {
        assertNBSnapshot(
            of: Button("Neutral No Shadow") {}
                .buttonStyle(.neoBrutalism(type: .neutral, variant: .noShadow))
        )
    }

    // MARK: - Buttons with Label or Multiline Text

    @Test func button_with_icon() {
        assertNBSnapshot(
            of: Button {} label: {
                Label("With Icon", systemImage: "star.fill")
            }
            .buttonStyle(.neoBrutalism())
        )
    }

    @Test func button_multiline_text() {
        assertNBSnapshot(
            of: Button {} label: {
                Text("This is a button\nwith multiple lines")
                    .multilineTextAlignment(.center)
            }
            .buttonStyle(.neoBrutalism())
        )
    }
}
