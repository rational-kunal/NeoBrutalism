import NeoBrutalism
import SnapshotTesting
import SwiftUI
import UIKit

public extension View {
    func prettifyForTest() -> some View {
        modifier(PrettifyForTestViewModifier())
    }
}

struct PrettifyForTestViewModifier: ViewModifier {
    @Environment(\.nbTheme) private var theme

    func body(content: Content) -> some View {
        content.padding(12.0).background(theme.background)
    }
}

/// Asserts light- and dark-mode snapshots of `view` at a fixed width with the repo's
/// standard tolerance. References land in `__Snapshots__/<TestFile>/<test>.{light|dark}.png`.
@MainActor
func assertNBSnapshot(
    of view: some View,
    width: CGFloat = 300,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
) {
    let subject = view.prettifyForTest().frame(width: width)
    for (variant, style) in [("light", UIUserInterfaceStyle.light), ("dark", .dark)] {
        assertSnapshot(
            of: subject,
            as: .image(
                precision: 0.995,
                perceptualPrecision: 0.98,
                layout: .sizeThatFits,
                traits: UITraitCollection(userInterfaceStyle: style)
            ),
            named: variant,
            fileID: fileID, file: filePath, testName: testName, line: line, column: column
        )
    }
}
