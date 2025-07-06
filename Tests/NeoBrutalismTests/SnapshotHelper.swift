import NeoBrutalism
import SnapshotTestingMacros
import SwiftUI

public extension View {
    func prettifyForTest() -> some View {
        modifier(PrettifyForTestViewModifer())
    }
}

struct PrettifyForTestViewModifer: ViewModifier {
    @Environment(\.nbTheme) private var theme

    func body(content: Content) -> some View {
        content.padding(12.0).background(theme.background)
    }
}
