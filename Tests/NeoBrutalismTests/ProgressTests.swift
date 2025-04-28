import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct ProgressTests {
    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func progress_0() -> some View {
        ProgressView(value: 0.0)
            .progressViewStyle(.neoBrutalism)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func progress_52() -> some View {
        ProgressView(value: 0.52)
            .progressViewStyle(.neoBrutalism)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func progress_20() -> some View {
        ProgressView(value: 0.2)
            .progressViewStyle(.neoBrutalism)
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(width: .fixed(300.0)))
    func progress_100() -> some View {
        ProgressView(value: 1.0)
            .progressViewStyle(.neoBrutalism)
    }
}
