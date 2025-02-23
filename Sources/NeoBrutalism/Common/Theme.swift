import SwiftUI

struct Theme {
    let clear: Color = .clear
    let main: Color
    let dark: Color
    let border: Color
    let text: Color
    let textDark: Color
}

extension Theme {
    static let standard = Theme(
        main: .init(
            light: .init(red: 0.53, green: 0.67, blue: 0.93),
            dark: .init(red: 0.53, green: 0.67, blue: 0.93)
        ),
        dark: .black,
        border: .black,
        text: .black,
        textDark: .white
    )
}

extension UIColor {
    convenience init(
        light lightModeColor: @escaping @autoclosure () -> UIColor,
        dark darkModeColor: @escaping @autoclosure () -> UIColor
    ) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightModeColor()
            case .dark:
                return darkModeColor()
            case .unspecified:
                return lightModeColor()
            @unknown default:
                return lightModeColor()
            }
        }
    }
}

extension Color {
    init(
        light lightModeColor: @escaping @autoclosure () -> Color,
        dark darkModeColor: @escaping @autoclosure () -> Color
    ) {
        self.init(UIColor(
            light: UIColor(lightModeColor()),
            dark: UIColor(darkModeColor())
        ))
    }
}

extension Color {
    var disabled: Color {
        self.opacity(0.5)
    }
}
