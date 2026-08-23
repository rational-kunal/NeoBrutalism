import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct LabeledContentTests {
    @Test func labeledContent_basic() {
        assertNBSnapshot(
            of: LabeledContent("Username", value: "johndoe")
                .labeledContentStyle(.neoBrutalism)
        )
    }

    @Test func labeledContent_longValue() {
        assertNBSnapshot(
            of: LabeledContent("Email", value: "user@example.com")
                .labeledContentStyle(.neoBrutalism)
        )
    }

    @Test func labeledContent_short() {
        assertNBSnapshot(
            of: LabeledContent("Plan", value: "Pro")
                .labeledContentStyle(.neoBrutalism)
        )
    }

    @Test func labeledContent_inside_groupBox() {
        assertNBSnapshot(
            of: GroupBox {
                VStack(spacing: 12) {
                    LabeledContent("Username", value: "johndoe")
                        .labeledContentStyle(.neoBrutalism)
                    LabeledContent("Email", value: "user@example.com")
                        .labeledContentStyle(.neoBrutalism)
                    LabeledContent("Plan", value: "Pro")
                        .labeledContentStyle(.neoBrutalism)
                }
            }
            .groupBoxStyle(.neoBrutalism())
        )
    }
}
