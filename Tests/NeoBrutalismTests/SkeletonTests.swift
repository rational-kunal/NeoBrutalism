import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SkeletonTests {
    // MARK: - Round Skeleton

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func roundSkeleton_default() -> some View {
        NBRoundSkeleton()
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func roundSkeleton_customSize() -> some View {
        NBRoundSkeleton()
            .frame(width: 120, height: 120)
            .prettifyForTest()
    }

    // MARK: - Text Skeleton

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func textSkeleton_default() -> some View {
        NBTextSkeleton()
            .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func textSkeleton_customSize() -> some View {
        NBTextSkeleton()
            .frame(width: 120, height: 20.0)
            .prettifyForTest()
    }
}
