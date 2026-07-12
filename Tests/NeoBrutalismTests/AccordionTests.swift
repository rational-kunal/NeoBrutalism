import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct AccordionTests {
    @Test func accordion_collapsed() {
        assertNBSnapshot(
            of: DisclosureGroup("Expecto Patronum") { Text("Hidden content") }
                .disclosureGroupStyle(.neoBrutalism)
        )
    }

    @Test func accordion_expanded() {
        assertNBSnapshot(
            of: DisclosureGroup("Expecto Patronum", isExpanded: .constant(true)) { Text("Hidden content") }
                .disclosureGroupStyle(.neoBrutalism)
        )
    }
}
