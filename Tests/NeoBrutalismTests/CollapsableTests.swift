import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct CollapsableTests {
    @Test func collapsable_collapsed() {
        assertNBSnapshot(
            of: NBCollapsable(isExpanded: .constant(false)) {
                GroupBox {
                    HStack {
                        Text("Some")
                        Spacer()
                        NBCollapsibleTrigger {
                            Image(systemName: "chevron.up.chevron.down.square.fill")
                        }
                    }
                }

                NBCollapsableContent {
                    GroupBox {
                        Text("Content")
                    }
                }
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
        )
    }

    @Test func collapsable_expanded() {
        assertNBSnapshot(
            of: NBCollapsable(isExpanded: .constant(true)) {
                GroupBox {
                    HStack {
                        Text("Some")
                        Spacer()
                        NBCollapsibleTrigger {
                            Image(systemName: "chevron.up.chevron.down.square.fill")
                        }
                    }
                }

                NBCollapsableContent {
                    GroupBox {
                        Text("Content")
                    }
                }
            }
            .groupBoxStyle(.neoBrutalism(elevated: false))
        )
    }
}
