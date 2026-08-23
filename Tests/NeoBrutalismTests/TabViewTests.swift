import NeoBrutalism
import SnapshotTesting
import SwiftUI
import Testing

@Suite(.snapshots) @MainActor
struct TabViewTests {
    @Test func tabView_firstSelected() {
        assertNBSnapshot(
            of: NBTabView(selection: .constant("account")) {
                NBTab("Account", value: "account") {
                    Text("Manage your account.")
                }
                NBTab("Password", value: "password") {
                    Text("Change your password.")
                }
            }
        )
    }

    @Test func tabView_secondSelected() {
        assertNBSnapshot(
            of: NBTabView(selection: .constant("password")) {
                NBTab("Account", value: "account") {
                    Text("Manage your account.")
                }
                NBTab("Password", value: "password") {
                    Text("Change your password.")
                }
            }
        )
    }

    @Test func tabView_systemImage() {
        assertNBSnapshot(
            of: NBTabView(selection: .constant(0)) {
                NBTab("Home", systemImage: "house.fill", value: 0) {
                    Text("Welcome home.")
                }
                NBTab("Search", systemImage: "magnifyingglass", value: 1) {
                    Text("Find anything.")
                }
            }
        )
    }

    @Test func tabView_customLabel_cardContent() {
        assertNBSnapshot(
            of: NBTabView(selection: .constant(1)) {
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
        )
    }

    @Test func tabView_selectionWithoutMatchingTab() {
        assertNBSnapshot(
            of: NBTabView(selection: .constant("missing")) {
                NBTab("Account", value: "account") {
                    Text("Manage your account.")
                }
                NBTab("Password", value: "password") {
                    Text("Change your password.")
                }
            }
        )
    }
}
