import NeoBrutalism
import SwiftUI
import Testing
import UIKit

@Suite
struct ThemePresetColorTests {
  @Test(arguments: [UIUserInterfaceStyle.light, .dark])
  func sunnyPeachBlank_staysWhite(style: UIUserInterfaceStyle) {
    let traits = UITraitCollection(userInterfaceStyle: style)
    let resolvedBlank = UIColor(NBTheme.sunnyPeach.blank).resolvedColor(with: traits)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    #expect(resolvedBlank.getRed(&red, green: &green, blue: &blue, alpha: &alpha))
    #expect(abs(red - 1) < 0.0001)
    #expect(abs(green - 1) < 0.0001)
    #expect(abs(blue - 1) < 0.0001)
    #expect(abs(alpha - 1) < 0.0001)
  }
}
