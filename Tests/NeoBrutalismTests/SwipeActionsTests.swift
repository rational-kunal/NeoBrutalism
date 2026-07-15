import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct SwipeActionsTests {
    // MARK: - Single-action row (revealed state)

    @Test func swipeActions_singleAction_revealed() {
        assertNBSnapshot(
            of: HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Delete Item")
                        .font(.headline)
                    Text("Swipe to reveal")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding(12)
            .nbListRow()
            .nbSwipeActions(
                actions: [
                    NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
                ],
                initialOffset: -100
            )
            .frame(height: 60)
        )
    }

    // MARK: - Closed state (at rest)

    /// Regression test: at rest, the destructive tile must stay fully hidden behind the row —
    /// no sliver of its fill should peek out past the row's trailing edge.
    @Test func swipeActions_singleAction_closed() {
        assertNBSnapshot(
            of: HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Delete Item")
                        .font(.headline)
                    Text("Swipe to reveal")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding(12)
            .nbListRow()
            .nbSwipeActions(
                actions: [
                    NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
                ]
            )
            .frame(height: 60)
        )
    }

    // MARK: - Two-action row (revealed state)

    @Test func swipeActions_twoActions_revealed() {
        assertNBSnapshot(
            of: HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Favorite Course")
                        .font(.headline)
                    Text("With options")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
            }
            .padding(12)
            .nbListRow()
            .nbSwipeActions(
                actions: [
                    NBSwipeAction("Pin", systemImage: "pin.fill", tint: .blue) {},
                    NBSwipeAction("Delete", systemImage: "trash", role: .destructive) {}
                ],
                initialOffset: -200
            )
            .frame(height: 60)
        )
    }
}
