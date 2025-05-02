import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct SkeletonTests {
    // MARK: - Round Skeleton

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func roundSkeleton_default() -> some View {
        NBRoundSkeleton()
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func roundSkeleton_customSize() -> some View {
        NBRoundSkeleton()
            .frame(width: 120, height: 120)
    }

    // MARK: - Text Skeleton

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func textSkeleton_default() -> some View {
        NBTextSkeleton()
    }

    @SnapshotTest(.padding(16.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func textSkeleton_customSize() -> some View {
        NBTextSkeleton()
            .frame(width: 120, height: 20.0)
    }
}
