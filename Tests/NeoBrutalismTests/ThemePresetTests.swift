import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct ThemePresetTests {
    @ViewBuilder
    private func cluster() -> some View {
        GroupBox("Card") {
            VStack(alignment: .leading, spacing: 12) {
                Button("Primary Button") {}
                Toggle("Enabled", isOn: .constant(true))
                NBBadge { Text("New") }
            }
        }
    }

    @Test func preset_sunnyPeach() {
        assertNBSnapshot(of: cluster().neoBrutalism(theme: .sunnyPeach, applyBackground: true))
    }

    @Test func preset_bubblegum() {
        assertNBSnapshot(of: cluster().neoBrutalism(theme: .bubblegum, applyBackground: true))
    }

    @Test func preset_seafoam() {
        assertNBSnapshot(of: cluster().neoBrutalism(theme: .seafoam, applyBackground: true))
    }

    @Test func preset_tangerine() {
        assertNBSnapshot(of: cluster().neoBrutalism(theme: .tangerine, applyBackground: true))
    }

    @Test func preset_lavender() {
        assertNBSnapshot(of: cluster().neoBrutalism(theme: .lavender, applyBackground: true))
    }
}
