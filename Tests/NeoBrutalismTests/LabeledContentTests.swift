import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct LabeledContentTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func labeledContent_basic() -> some View {
        LabeledContent("Username", value: "johndoe")
            .labeledContentStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func labeledContent_longValue() -> some View {
        LabeledContent("Email", value: "user@example.com")
            .labeledContentStyle(.neoBrutalism)
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func labeledContent_short() -> some View {
        LabeledContent("Plan", value: "Pro")
            .labeledContentStyle(.neoBrutalism)
            .prettifyForTest()
    }
}
