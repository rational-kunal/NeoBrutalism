import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@MainActor @Suite @SnapshotSuite
struct ButtonStyleTests {
    // MARK: - Default Type

    @SnapshotTest func button_default() -> some View {
        Button("Default") {}
            .buttonStyle(.neoBrutalism())
            .prettifyForTest()
    }

    @SnapshotTest func button_default_pressed_reverse() -> some View {
        Button("Default Reverse") {}
            .buttonStyle(.neoBrutalism(variant: .reverse))
            .prettifyForTest()
    }

    @SnapshotTest func button_default_noShadow() -> some View {
        Button("Default No Shadow") {}
            .buttonStyle(.neoBrutalism(variant: .noShadow))
            .prettifyForTest()
    }

    // MARK: - Neutral Type

    @SnapshotTest func button_neutral() -> some View {
        Button("Neutral") {}
            .buttonStyle(.neoBrutalism(type: .neutral))
            .prettifyForTest()
    }

    @SnapshotTest func button_neutral_reverse() -> some View {
        Button("Neutral Reverse") {}
            .buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
            .prettifyForTest()
    }

    @SnapshotTest func button_neutral_noShadow() -> some View {
        Button("Neutral No Shadow") {}
            .buttonStyle(.neoBrutalism(type: .neutral, variant: .noShadow))
            .prettifyForTest()
    }

    // MARK: - Buttons with Label or Multiline Text

    @SnapshotTest func button_with_icon() -> some View {
        Button {} label: {
            Label("With Icon", systemImage: "star.fill")
        }
        .buttonStyle(.neoBrutalism())
        .prettifyForTest()
    }

    @SnapshotTest func button_multiline_text() -> some View {
        Button {} label: {
            Text("This is a button\nwith multiple lines")
                .multilineTextAlignment(.center)
        }
        .buttonStyle(.neoBrutalism())
        .prettifyForTest()
    }
}
