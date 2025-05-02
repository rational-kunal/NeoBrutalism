import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

// These tests do not work
/*@Suite @SnapshotSuite*/ @MainActor
struct DrawerTests {
    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(devices: .iPhoneX))
    func drawer_basic_text() -> some View {
        Group {}
            .nbDrawer(isPresented: .constant(true)) {
                Text("This is a simple drawer")
            }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(devices: .iPhoneX))
    func drawer_with_title_and_button() -> some View {
        Group {}
            .nbDrawer(isPresented: .constant(true)) {
                VStack(spacing: 16) {
                    Text("Terms & Conditions")
                        .font(.headline)

                    Text("By using this app, you accept our extremely strict but fair magical rules.")

                    Button("Accept") {}
                        .buttonStyle(.neoBrutalism())
                }
            }
    }

    @SnapshotTest(.padding(4.0), .backgroundColor(NBTheme.default.background), .sizes(devices: .iPhoneX))
    func drawer_with_icon_and_multiline() -> some View {
        Group {}
            .nbDrawer(isPresented: .constant(true)) {
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                        Text("Magic Agreement")
                            .font(.title2)
                    }

                    Text("This spell requires your approval. Proceed with caution and a sense of wonder.").multilineTextAlignment(.center)

                    Button("Proceed") {}
                        .buttonStyle(.neoBrutalism())
                }
                .padding()
            }
    }
}
