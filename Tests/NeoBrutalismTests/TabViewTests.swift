import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI
import Testing

@Suite @SnapshotSuite @MainActor
struct TabViewTests {
    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func tabView_firstSelected() -> some View {
        NBTabView(selection: .constant("account")) {
            NBTab("Account", value: "account") {
                Text("Manage your account.")
            }
            NBTab("Password", value: "password") {
                Text("Change your password.")
            }
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func tabView_secondSelected() -> some View {
        NBTabView(selection: .constant("password")) {
            NBTab("Account", value: "account") {
                Text("Manage your account.")
            }
            NBTab("Password", value: "password") {
                Text("Change your password.")
            }
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func tabView_systemImage() -> some View {
        NBTabView(selection: .constant(0)) {
            NBTab("Home", systemImage: "house.fill", value: 0) {
                Text("Welcome home.")
            }
            NBTab("Search", systemImage: "magnifyingglass", value: 1) {
                Text("Find anything.")
            }
        }
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func tabView_customLabel_cardContent() -> some View {
        NBTabView(selection: .constant(1)) {
            NBTab(value: 0) {
                GroupBox { Text("Bravery and Daring!") }
            } label: {
                Image(systemName: "flame.fill")
            }
            NBTab(value: 1) {
                GroupBox { Text("Cunning and Ambition!") }
            } label: {
                Image(systemName: "lanyardcard.fill")
            }
            NBTab(value: 2) {
                GroupBox { Text("Wisdom and Learning!") }
            } label: {
                Image(systemName: "book.fill")
            }
        }
        .groupBoxStyle(.neoBrutalism(elevated: false))
        .prettifyForTest()
    }

    @SnapshotTest(.sizes(width: .fixed(300.0)))
    func tabView_selectionWithoutMatchingTab() -> some View {
        NBTabView(selection: .constant("missing")) {
            NBTab("Account", value: "account") {
                Text("Manage your account.")
            }
            NBTab("Password", value: "password") {
                Text("Change your password.")
            }
        }
        .prettifyForTest()
    }
}
