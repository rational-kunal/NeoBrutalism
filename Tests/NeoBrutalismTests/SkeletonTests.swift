import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct SkeletonTests {
    // MARK: - Round Skeleton

    @Test func roundSkeleton_default() {
        assertNBSnapshot(of: NBRoundSkeleton())
    }

    @Test func roundSkeleton_customSize() {
        assertNBSnapshot(
            of: NBRoundSkeleton()
                .frame(width: 120, height: 120)
        )
    }

    // MARK: - Text Skeleton

    @Test func textSkeleton_default() {
        assertNBSnapshot(of: NBTextSkeleton())
    }

    @Test func textSkeleton_customSize() {
        assertNBSnapshot(
            of: NBTextSkeleton()
                .frame(width: 120, height: 20.0)
        )
    }

    // MARK: - Skeleton Modifier

    @Test func skeletonModifier_active() {
        assertNBSnapshot(
            of: HStack(spacing: 12.0) {
                NBRoundSkeleton()
                    .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 4.0) {
                    NBTextSkeleton()
                        .frame(height: 12.0)

                    NBTextSkeleton()
                        .frame(maxWidth: 120)
                        .frame(height: 8.0)
                }
            }
            .nbSkeleton(active: true)
        )
    }
}
